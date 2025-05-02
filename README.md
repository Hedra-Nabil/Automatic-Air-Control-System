
# 🔥 Automatic Air Control System using PIC18F45K22

An embedded system that intelligently monitors and controls air temperature using the PIC18F45K22 microcontroller. The system compares user-defined temperature input with real-time sensor readings to activate either a heater or a fan, ensuring optimal environmental conditions.

---

## 🖼️ System Circuit Diagram

![System Diagram](https://github.com/Hedra-Nabil/Automatic-Air-Control-System/blob/main/simulation/file_2025-05-02_09.35.42.png)

---

## 📌 Project Overview

This project allows users to set a reference temperature through a keypad. Based on this reference, the system continuously reads ambient temperature using an LM35 sensor. It reacts accordingly:
- If the actual temperature is **lower** than desired → it **activates the heater**.
- If it's **higher** → it **turns on the fan**.
- If it's **equal** → both remain **off**.

---

## 🧠 System Features

- Real-time temperature monitoring.
- Automatic switching between heating and cooling.
- User-defined temperature input.
- Visual feedback via LCD screen.
- Warnings for extreme temperatures.

---

## 🧰 Hardware Components

| Component       | Description                      |
|----------------|----------------------------------|
| PIC18F45K22     | Main microcontroller             |
| LM35            | Analog temperature sensor        |
| 16x2 LCD        | Displays values and system status|
| 4x4 Keypad      | User input for reference temp    |
| Fan + Relay     | Cooling system                   |
| Heater + Relay  | Heating system                   |
| Transistors     | Switching control for relays     |
| Power Supply    | 5V regulated                     |

---

## 🔁 System Logic Flow

1. **Startup screen** → "Welcome to Temperature System"
2. **User Input** → Set desired temperature via keypad.
3. **Comparison** → Actual vs. Reference.
4. **Control**:
   - Turn ON heater if too cold.
   - Turn ON fan if too hot.
   - Turn both OFF if stable.
5. **Alerts**:
   - Displays "So Hot" or "So Cold" for critical cases.

---

## ⚙️ How Temperature is Calculated

```c
temp = ADC_Read(0);                  // Read analog voltage
mV = temp * 5000.0 / 1024.0;         // Convert to mV
ActualTemp = mV / 10.0;              // LM35 = 10mV/°C
```

---

## 💻 Software Tools

- **MPLAB X / MikroC** – For code development.
- **Proteus 8** – For circuit simulation and testing.
- **Pickit3** – For programming the microcontroller.

---

## 📦 Repository Contents

| File                          | Description                         |
|-------------------------------|-------------------------------------|
| `AutomaticControlSystem.c`    | Main embedded C code                |
| `file_2025-05-02_09.35.42.png`| System diagram screenshot (Proteus) |
| `README.md`                   | Project documentation               |

---

## 👥 Contributors

Special thanks to the project team:

- **Hedra-Nabil**   
- **[nagham959]**(https://github.com/nagham959)  


---

## 🚀 Future Improvements

- Add buzzer alert for critical temp conditions.
- Interface with Bluetooth for mobile control.
- Store last-used temperature in EEPROM.
- Replace LCD with OLED for better visuals.
- Implement automatic fan speed control using PWM.

---

## 📄 License

This project is open-source and free for educational and personal use.

---

## 💬 Contact

For feedback or collaboration:
- GitHub: [github.com/Hedra-Nabil](https://github.com/Hedra-Nabil)
