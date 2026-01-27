import Flutter
import UIKit
import Darwin

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return result
    }
    
    let methodChannel = FlutterMethodChannel(
      name: "com.example.device_vitals",
      binaryMessenger: controller.binaryMessenger
    )
    
    methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      switch call.method {
      case "getBatteryLevel":
        self?.getBatteryLevel(result: result)
      case "getMemoryUsage":
        self?.getMemoryUsage(result: result)
      case "getThermalStatus":
        self?.getThermalStatus(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    return result
  }
  
  private func getBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    
    let batteryLevel = device.batteryLevel
    
    if batteryLevel < 0 {
      result(FlutterError(
        code: "FAIL",
        message: "Battery level not available",
        details: nil
      ))
    } else {
      result(Int((batteryLevel * 100).rounded()))
    }
  }
  
  private func getMemoryUsage(result: FlutterResult) {
    var info = mach_task_basic_info_data_t()
    var count = mach_msg_type_number_t(
      MemoryLayout<mach_task_basic_info_data_t>.size / MemoryLayout<natural_t>.size
    )
    
    var task: mach_port_t = mach_task_self_
    
    let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
      $0.withMemoryRebound(
        to: integer_t.self,
        capacity: Int(count)
      ) {
        task_info(
          task,
          task_flavor_t(MACH_TASK_BASIC_INFO),
          $0,
          &count
        )
      }
    }
    
    if kerr == KERN_SUCCESS {
      let usedMemory = Double(info.resident_size)
      let totalMemory = Double(ProcessInfo.processInfo.physicalMemory)
      
      guard totalMemory > 0 else {
        result(FlutterError(
          code: "FAIL",
          message: "Memory info not available",
          details: nil
        ))
        return
      }
      
      let usagePercent = Int((usedMemory / totalMemory) * 100)
      result(usagePercent)
    } else {
      result(FlutterError(
        code: "FAIL",
        message: "Memory info not available",
        details: nil
      ))
    }
  }
  
  private func getThermalStatus(result: FlutterResult) {
    if #available(iOS 11.0, *) {
      let thermalState = ProcessInfo.processInfo.thermalState
      switch thermalState {
      case .nominal:
        result(0)
      case .fair:
        result(1)
      case .serious:
        result(2)
      case .critical:
        result(3)
      @unknown default:
        result(FlutterError(
          code: "FAIL",
          message: "Thermal status not available",
          details: nil
        ))
      }
    } else {
      result(FlutterError(
        code: "FAIL",
        message: "Thermal status not available",
        details: nil
      ))
    }
  }
}
