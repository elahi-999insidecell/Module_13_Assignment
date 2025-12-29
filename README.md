# Module 13 – BMI Calculator (Flutter)

This is a Flutter-based BMI (Body Mass Index) Calculator developed as part of Module 13 assignment.  
The app allows users to calculate BMI using different height and weight units and displays the result with appropriate health categories and colors.

---

## BMI Formula Used

BMI is calculated using the standard formula:

BMI = weight (kg) / [height (m) × height (m)]

The BMI value is calculated using full precision internally and displayed up to one decimal place.

---

## Unit Conversions

The following unit conversions are used in the application:

- **Centimeter to Meter:**  
  meter = cm / 100

- **Feet & Inch to Meter:**  
  meter = (feet × 12 + inch) × 0.0254

- **Pound to Kilogram (if used):**  
  kg = pound × 0.453592

All conversion functions are kept small and reusable.

---

## BMI Categories & Color Mapping
