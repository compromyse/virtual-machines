cd C:\Users\vagrant\Downloads

curl https://us.download.nvidia.com/Windows/555.99/555.99-notebook-win10-win11-64bit-international-dch-whql.exe -L -o nvidia.exe
curl https://github.com/itsmikethetech/Virtual-Display-Driver/releases/download/23.10.20.2/VDD.23.10.20.2.zip -L -o VDD.zip
curl https://looking-glass.io/artifact/B7-rc1/host -L -o LG.zip

tar xf LG.zip
tar xf VDD.zip
cd IddSampleDriver

mkdir C:\IddSampleDriver

copy option.txt C:\IddSampleDriver
@echo | installCert.bat

copy iddsampledriver.inf C:\Users\vagrant\Downloads
copy iddsampledriver.dll C:\Users\vagrant\Downloads
copy iddsampledriver.cat C:\Users\vagrant\Downloads

cd ..
@echo Y | del VDD.zip IddSampleDriver
rmdir IddSampleDriver
