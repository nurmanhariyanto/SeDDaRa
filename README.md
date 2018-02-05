# SeDDaRa
Image Deblurring using SeDDaRA and Richardson-Lucy with MATLAB


HOW TO:
1. Download https://gist.github.com/nurmanhariyanto/e63024c5c2b039dc4eb5b7388dcfe3cb/archive/.zip to your disk.
2. Run your MATLAB.
3.Open file. 
4. Input your image test and image reference
 TestImg = imread('citra_uji'); %mengambil citra retina
RefImg = imread('citra_referensi'); %mengambil citra referensi untuk dijadikan psf
NB: your image must be one location with your code.

Example : with 20 iteration Richardson+Lucy
![seddara 20](https://user-images.githubusercontent.com/18458955/35786301-e983eac4-0a58-11e8-8516-9bded527b0cc.jpg)
