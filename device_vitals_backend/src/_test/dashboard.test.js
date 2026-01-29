const { calculateMetrics } = require('../utils/dashboard');

describe('Rolling Average Calculation', () => {
  
  describe('calculateMetrics - Rolling Average Logic', () => {
    
    test('should calculate rolling average from last 3 values when array has more than 3 items', () => {
      const values = [10, 20, 30, 40, 50];
      const result = calculateMetrics(values);
      
      // Rolling average should be average of last 3: (30 + 40 + 50) / 3 = 40
      expect(result.rolling_average).toBe(40);
    });

    test('should calculate rolling average from all values when array has exactly 3 items', () => {
      const values = [10, 20, 30];
      const result = calculateMetrics(values);
      
      // Rolling average should be: (10 + 20 + 30) / 3 = 20
      expect(result.rolling_average).toBe(20);
    });

    test('should calculate rolling average from all values when array has less than 3 items', () => {
      const values = [10, 20];
      const result = calculateMetrics(values);
      
      // Rolling average should be: (10 + 20) / 2 = 15
      expect(result.rolling_average).toBe(15);
    });

    test('should calculate rolling average correctly with single value', () => {
      const values = [25];
      const result = calculateMetrics(values);
      
      // Rolling average should be the value itself: 25 / 1 = 25
      expect(result.rolling_average).toBe(25);
    });

    test('should calculate rolling average with decimal values', () => {
      const values = [1.5, 2.5, 3.5, 4.5, 5.5];
      const result = calculateMetrics(values);
      
      // Rolling average of last 3: (3.5 + 4.5 + 5.5) / 3 = 4.5
      expect(result.rolling_average).toBe(4.5);
    });

    test('should calculate rolling average correctly with negative values', () => {
      const values = [-10, -5, 0, 5, 10];
      const result = calculateMetrics(values);
      
      // Rolling average of last 3: (0 + 5 + 10) / 3 = 5
      expect(result.rolling_average).toBe(5);
    });

    test('should handle rolling average with large dataset', () => {
      const values = Array.from({ length: 100 }, (_, i) => i + 1);
      const result = calculateMetrics(values);
      
      // Rolling average of last 3: (98 + 99 + 100) / 3 = 99
      expect(result.rolling_average).toBe(99);
    });

    test('should return null for empty array', () => {
      const values = [];
      const result = calculateMetrics(values);
      
      expect(result).toBeNull();
    });

    test('should calculate rolling average with repeating values', () => {
      const values = [5, 5, 5, 10, 10, 10];
      const result = calculateMetrics(values);
      
      // Rolling average of last 3: (10 + 10 + 10) / 3 = 10
      expect(result.rolling_average).toBe(10);
    });

    test('should ensure rolling average is calculated from last 3, not first 3', () => {
      const values = [100, 200, 300, 1, 2, 3];
      const result = calculateMetrics(values);
      
      // Rolling average should be from last 3: (1 + 2 + 3) / 3 = 2
      // NOT from first 3: (100 + 200 + 300) / 3 = 200
      expect(result.rolling_average).toBe(2);
      expect(result.rolling_average).not.toBe(200);
    });
  });

  describe('calculateMetrics - Complete Metrics', () => {
    
    test('should return all metrics including rolling average', () => {
      const values = [10, 20, 30, 40, 50];
      const result = calculateMetrics(values);
      
      expect(result).toHaveProperty('average');
      expect(result).toHaveProperty('rolling_average');
      expect(result).toHaveProperty('min');
      expect(result).toHaveProperty('max');
    });

    test('should calculate correct average alongside rolling average', () => {
      const values = [10, 20, 30, 40, 50];
      const result = calculateMetrics(values);
      
      // Average of all: (10 + 20 + 30 + 40 + 50) / 5 = 30
      expect(result.average).toBe(30);
      // Rolling average of last 3: (30 + 40 + 50) / 3 = 40
      expect(result.rolling_average).toBe(40);
    });
  });
});