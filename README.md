# Driver-Drowsiness-Detection-and-Alert-System-MIPS-Assembly_MARS-
This project simulates a **Driver Drowsiness Detection System** using **MIPS Assembly Language** on the **MARS simulator**.   It models real-world safety features found in modern vehicles by monitoring: 

- Eye state (open / closed)
- Heart rate (normal / abnormal)
- Steering movement consistency
- Driver response after alert

If an unsafe pattern is detected (e.g.: eye closure + abnormal heart rate + steering inconsistency), the system triggers escalating alerts.

---

## Features

### 1) Eye State Detection  
User inputs:  
- `1` → Eyes open  
- `0` → Eyes closed  

### 2) Heart Rate Monitoring  
User inputs:  
- `1` → Normal  
- `0` → Abnormal  

### 3) Steering Movement Tracking  
User inputs:  
- `1` → Consistent  
- `0` → Inconsistent  

### 4) Alert System  
- Initial warning  
- Checks if driver responds  
- If unresponsive → **Escalated emergency alert**

### 5) Continuous Monitoring  
After each cycle, driver can choose:  
- `1` → Continue  
- `0` → Stop program

---

## Requirements

- **MARS 4.5** or newer  
To download, just search "MARS MIPS simulator" online

---

## ▶ How to Run

1. Open **MARS**
2. Load the file:  
   ```
   drowsiness_detection.asm
   ```
3. Assemble the program (F3)
4. Run (F5)
5. Follow the on-screen prompts

---

## Project Structure

```
📁 drowsiness-detection/
│── README.md
│── drowsiness_detection.asm
```

---

## Example Input Flow (User Interaction)

```
Initializing Camera, Heart Rate Sensor...
Detecting eyes...
Detection successful!
Eyes State. Monitoring...(0 = closed, 1 = open)
> 0
Eyes Closed...
Checking Heart Rate...(1 = normal, 0 = abnormal)
> 0
Heart Rate is abnormal...
Checking Steering Movement...(1 = consistent, 0 = inconsistent)
> 0
Steering Movement is inconsistent...
Driver Drowsy! Triggering Alert...(1 = reacted, 0 = unresponsive)
> 0
Driver Unresponsive. Escalating Alert...
```

---

## 📜 License
This project is for educational use.

---

## ✨ Authors
Iman A., Zullaikha Z., Aisha A., Sofia M.  
Created as part of Computer Architecture and Assembly Language group project.
