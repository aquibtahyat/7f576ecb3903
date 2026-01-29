const { addDeviceVitalsValidator } = require('../validations/deviceVitalsValidator');

describe('Data Validation - Sensor Values', () => {
  
  describe('Thermal Value Validation', () => {
    
    test('should accept valid thermal value (0)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 0,
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should accept valid thermal value (3)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 3,
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should accept valid thermal value (1.5)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 1.5,
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should reject thermal value less than 0', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: -1,
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].path).toContain('thermal_value');
    });

    test('should reject thermal value greater than 3', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 4,
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].path).toContain('thermal_value');
    });

    test('should reject thermal value as string', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: '2',
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
    });

    test('should reject missing thermal value', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].path).toContain('thermal_value');
    });
  });

  describe('Battery Level Validation', () => {
    
    test('should accept valid battery level (0)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 0,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should accept valid battery level (100)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 100,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should accept valid battery level (50)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should reject battery level less than 0', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: -1,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].message).toContain('cannot be less than 0');
    });

    test('should reject battery level greater than 100', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 101,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].message).toContain('cannot exceed 100');
    });

    test('should reject battery level as string', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: '50',
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
    });

    test('should reject missing battery level', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        memory_usage: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].path).toContain('battery_level');
    });
  });

  describe('Memory Usage Validation', () => {
    
    test('should accept valid memory usage (0)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50,
        memory_usage: 0
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should accept valid memory usage (100)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50,
        memory_usage: 100
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should accept valid memory usage (75.5)', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50,
        memory_usage: 75.5
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });

    test('should reject memory usage less than 0', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50,
        memory_usage: -1
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].message).toContain('cannot be negative');
    });

    test('should reject memory usage greater than 100', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50,
        memory_usage: 101
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
    });

    test('should reject memory usage as string', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50,
        memory_usage: '50'
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
    });

    test('should reject missing memory usage', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2,
        battery_level: 50
      };
      
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].path).toContain('memory_usage');
    });
  });

  describe('Multiple Invalid Values', () => {
    
    test('should reject multiple invalid sensor values at once', () => {
      const invalidData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 5,      // Invalid: > 3
        battery_level: 150,    // Invalid: > 100
        memory_usage: -10      // Invalid: < 0
      };

      const { error } = addDeviceVitalsValidator.validate(invalidData, {
        abortEarly: false
      });
      expect(error).toBeDefined();
      expect(error.details.length).toBeGreaterThan(1);
    });

    test('should validate all sensor values correctly together', () => {
      const validData = {
        device_id: 'device123',
        timestamp: '2026-01-27T10:00:00Z',
        thermal_value: 2.5,
        battery_level: 75,
        memory_usage: 60
      };
      
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });
  });

  describe('Timestamp Validation', () => {
    test('should reject future timestamp', () => {
      const futureDate = new Date();
      futureDate.setFullYear(futureDate.getFullYear() + 1);
      const invalidData = {
        device_id: 'device123',
        timestamp: futureDate.toISOString(),
        thermal_value: 2,
        battery_level: 50,
        memory_usage: 50
      };
      const { error } = addDeviceVitalsValidator.validate(invalidData);
      expect(error).toBeDefined();
      expect(error.details[0].path).toContain('timestamp');
    });

    test('should accept past timestamp', () => {
      const pastDate = new Date();
      pastDate.setFullYear(pastDate.getFullYear() - 1);
      const validData = {
        device_id: 'device123',
        timestamp: pastDate.toISOString(),
        thermal_value: 2,
        battery_level: 50,
        memory_usage: 50
      };
      const { error } = addDeviceVitalsValidator.validate(validData);
      expect(error).toBeUndefined();
    });
  });
});