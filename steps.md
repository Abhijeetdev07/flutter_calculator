# Speed Conversion Feature - Implementation Steps

## 1. Project Structure Setup
1.1. Create directory `lib/screens/tools`
1.2. Create directory `lib/screens/converters`
1.3. Create directory `lib/widgets/converter`
1.4. Create directory `lib/constants/converter_data`

## 2. Constants & Data Models
2.1. Create file `lib/constants/converter_data/speed_units.dart`
   - Define `SpeedUnit` enum with values:
     - `lightSpeed` (Speed of Light - 299,792,458 m/s)
     - `meterPerSecond` (m/s)
     - `kilometerPerSecond` (km/s)
     - `kilometerPerHour` (km/h)
     - `knot` (kn)
     - `milesPerHour` (mph)
     - `footPerSecond` (ft/s)
     - `inchPerSecond` (in/s)

2.2. Create conversion data class
   - Define `SpeedUnitData` class with:
     - `String displayName`
     - `String symbol`
     - `double conversionToMeterPerSecond` (base unit)
   
2.3. Create unit map
   - Map each `SpeedUnit` to its `SpeedUnitData`

## 3. Converter Logic Implementation
3.1. Create file `lib/utils/speed_converter.dart`
3.2. Implement `SpeedConverter` class with methods:
   - `convert(double value, SpeedUnit from, SpeedUnit to)` → Returns converted value
   - Logic: Convert input to m/s (base unit), then to target unit

## 4. UI Components - Converter Widgets
4.1. Create file `lib/widgets/converter/unit_dropdown.dart`
   - Create `UnitDropdown` widget
   - Accept: `List<SpeedUnit> units`, `SpeedUnit selectedUnit`, `ValueChanged<SpeedUnit> onChanged`
   - Returns: `DropdownButton` with styled dropdown menu

4.2. Create file `lib/widgets/converter/conversion_display.dart`
   - Create `ConversionDisplay` widget
   - Accept: `String value`, `String label`
   - Returns: Display box showing converted value with large text

4.3. Create file `lib/widgets/converter/number_pad.dart`
   - Create `NumberPad` widget for input
   - Include digits 0-9, decimal point, and clear button
   - Returns: Grid of buttons styled like calculator

## 5. Speed Conversion Screen
5.1. Create file `lib/screens/converters/speed_conversion_screen.dart`
5.2. Create `SpeedConversionScreen` StatefulWidget
5.3. Define state variables:
   - `String inputValue` (current input)
   - `SpeedUnit fromUnit` (default: m/s)
   - `SpeedUnit toUnit` (default: km/h)
   - `String outputValue` (converted result)

5.4. Implement conversion logic:
   - `onUnitChanged()` - When dropdown changes
   - `onNumberPressed(String digit)` - When number pad pressed
   - `calculateConversion()` - Perform actual conversion

5.5. Build UI layout:
   - `AppBar` with title "Speed Conversion"
   - `Column` layout:
     - From Section:
       - `UnitDropdown` for source unit
       - `ConversionDisplay` for input value
     - Swap button (to swap from/to units)
     - To Section:
       - `UnitDropdown` for target unit
       - `ConversionDisplay` for output value
     - `NumberPad` at bottom

## 6. Tools Screen (Grid of Converters)
6.1. Create file `lib/screens/tools/tools_screen.dart`
6.2. Create `ToolsScreen` StatelessWidget
6.3. Define tool items list:
   - Speed Conversion tool with icon and label

6.4. Build UI layout:
   - `AppBar` with title "Tools"
   - `GridView` with tool cards:
     - Each card shows icon and label
     - `onTap` navigates to respective converter screen
     - Use `GridView.builder` with 2-3 columns

6.5. Create helper method `_buildToolCard`:
   - Accept: `IconData icon`, `String label`, `VoidCallback onTap`
   - Returns: Card with centered icon and text

## 7. Swipe Gesture Implementation
7.1. Modify file `lib/screens/calculator_home.dart`
7.2. Wrap calculator screen content with `GestureDetector`
7.3. Implement `onHorizontalDragEnd`:
   - Detect swipe direction (right to left)
   - If velocity.primaryVelocity < -500 (swipe left):
     - Navigate to `ToolsScreen`

7.4. Alternative: Use `PageView` for smoother swiping:
   - Wrap `CalculatorHome` and `ToolsScreen` in `PageView`
   - Set initial page to 0 (Calculator)
   - Allow horizontal scrolling

## 8. Navigation Setup
8.1. Modify `lib/main.dart` if using routes:
   - Define named routes:
     - `/` → `CalculatorHome`
     - `/tools` → `ToolsScreen`
     - `/speed-conversion` → `SpeedConversionScreen`

8.2. Or use `Navigator.push` in gesture handler:
   - Push `ToolsScreen` when swipe detected
   - Push `SpeedConversionScreen` when tool card tapped

## 9. Styling & Theme Consistency
9.1. Update `lib/constants/colors.dart` if needed:
   - Add converter-specific colors
   - Ensure consistency with calculator theme

9.2. Apply dark theme to converter screens:
   - Match iOS 18 aesthetic
   - Use similar button styles
   - Maintain orange accent where appropriate

## 10. Testing & Verification
10.1. Test swipe gesture:
   - Swipe left on calculator screen
   - Verify tools page opens smoothly

10.2. Test tools screen:
   - Verify grid layout displays correctly
   - Tap speed conversion icon
   - Verify navigation to speed conversion screen

10.3. Test speed conversion:
   - Input values using number pad
   - Change units in dropdowns
   - Verify conversion calculations are accurate
   - Test all unit combinations
   - Test edge cases (0, very large numbers, decimals)

10.4. Test swipe back:
   - Implement back navigation or reverse swipe
   - Verify smooth return to calculator

## 11. Optional Enhancements
11.1. Add animation to page transitions
11.2. Add haptic feedback on button press
11.3. Add scientific notation for very large/small numbers
11.4. Add history of recent conversions
11.5. Add more converter tools (temperature, length, weight, etc.)
