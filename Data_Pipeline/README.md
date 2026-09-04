In development Phase

# 1. Setting up your Laptop 

Connect the bot with your laptop via ethernet.

## Windows 11

1. Open PowerShell in administrative mode and run `Get-NetAdapter` to list the connections.
2. Find the one that's your bot's Ethernet. Replace `Ethernet` with your Ethernet name in the following commands. And then run this commands:
```
Remove-NetIPAddress -InterfaceAlias "Ethernet" -Confirm:$false
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.10.2 -PrefixLength 24
Set-DNsCLientServerAddress -InterfaceAlias "Ethernet" -ResetServerAddresses
```
3. Check if the connection is successfully established by runnig this in powershell `ping 192.168.10.2`

## Linux

Connect the bot with your laptop via ethernet.

1. Open a terminal and identify your Ethernet interface name (e.g., `eth0` or `enp3s0`) by running `ip link`.
2. Assign the required static IP address to your laptop. Using NetworkManager, which is the same tool the Raspberry Pi setup uses, run the following commands (replace `<interface>` with your actual interface name):  
    * `sudo nmcli connection add con-name "bot-link" ifname <interface> type ethernet ipv4.addresses 192.168.10.2/24 ipv4.method manual`
    * `sudo nmcli connection up "bot-link"`
3. Verify the connection is active by pinging the Raspberry Pi with `ping 192.168.10.1`.  

## Installing python dependencies

Now that connection is successfully established, we will setup an virtual environment for python, install the requirements and run the script.

1. Install pip:
    * Windows: Download the official installer from Python.org. Crucial: Check the box that says "Add python.exe to PATH" before clicking install.
    * Linux: `sudo pacman -S python3 python3-pip python3-venv` or `sudo apt install python3 python3-pip python3-venv`.
2. Navigate to the folder `Project_Arachnid/Data_Pipeline/Laptop`.
3. Create the virtual environment `python -m venv .venv`.
4. Activate virtual environment
    * Windows: Command prompt - `.venv/Scripts/activate.bat`, Powershell - `.venv\Scripts\Activate.ps1`
    * Linux: `source .venv/bin/activate`.
5. Installing dependencies: `pip install -r requirements.txt`.
6. To Deactivate when done run `deactivate`. 
7. Run `python3 laptop_server.py` and navigate to `localhost:5000` in your browser.

**Now your laptop is all set.**

# 2. Setting up Raspberry Pi 5 for the Bot
The RPi should have Raspberry Pi OS Trixie

1. Clone the repo and go into RPi folder.
```
git clone "https://github.com/Kanak-101/Project_Arachnid"
cd Project_Arachnid/Data_Pipeline/RPi
```
2. Run `make` and your environment will be set up.
3. To run the script `python3 rpi_node.py`
