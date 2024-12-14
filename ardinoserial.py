import serial
import subprocess
import shutil
SERIAL_PORT = '/dev/ttyUSB0'  # Replace with your actual port
BAUD_RATE = 9600
terminals = ["gnome-terminal", "xfce4-terminal", "lxterminal", "konsole", "xterm"]
try:
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    print(f"Listening on {SERIAL_PORT}...")

    while True:
        data = ser.readline().decode('utf-8').strip()
        if data:
            print(f"Received: {data}")
            print("Opening terminal...")
            if data == "UID tag : 33 9B 23 DA":  # Check for specific UID
                for terminal in terminals:
                    if shutil.which(terminal):  # Check if the terminal is installed
                        subprocess.run([terminal])
                        
                else:
                    print("No compatible terminal emulator found!")   
            if data == "UID tag : 04 89 71 8A 1B 12 91":
                print("Opening Chrome...")
                subprocess.run(["google-chrome","https://durg.dcourts.gov.in/"])                 

except Exception as e:
    print(f"Error: {e}")

finally:
    if 'ser' in locals() and ser.is_open:
        ser.close()
        print(f"Serial port {SERIAL_PORT} closed.")
