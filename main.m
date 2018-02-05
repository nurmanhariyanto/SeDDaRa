                                close all;
                                close all; clc;

                                tic %menghitung  waktu proses
                                TestImg = imread('citra_uji'); %mengambil citra retina
                                RefImg = imread('citra_referensi'); %mengambil citra referensi untuk dijadikan psf
                                GryImg = rgb2gray(TestImg);%mengubah citra uji ke mode grayscale
                                GryImgRef = rgb2gray(RefImg);%mengubah citra referensi mke mode grayscale


                                % proses smoothing
                                MedImg = medfilt2 (GryImg);%filter median
                                [baris,kolom]=size(MedImg);

                                %proses mencari PSF dari citra referensi
                                %FFT
                                fMedImg = fft2(MedImg);
                                fRefImg = fft2 (GryImgRef);

                                %operator smoothing pada SeDDaRA 
                                h= fspecial('gaussian',[ukuran_kernel], (standar deviasi);
                                sMedImg = imfilter(abs(fMedImg),h);
                                sRefImg = imfilter(abs(fRefImg),h);
                                Kg = 1/max(max(sMedImg));

                                %hitung alpha
                                 for u = 1:baris
                                     for v = 1:kolom
                                         alpha(u,v)=(log(sRefImg(u,v))-log(sMedImg(u,v)))/(log(sRefImg(u,v)));
                                         if(alpha(u,v)<0)
                                             alpha(u,v)=0;
                                         elseif(alpha(u,v)>1)
                                             alpha(u,v)=1;
                                         end
                                     end
                                 end

                                 %hitung h(u,v)
                                 for u = 1:baris
                                     for v = 1:kolom
                                         fPSF(u,v)=(Kg*sMedImg(u,v)).^alpha(u,v);
                                     end	
                                 end

                                 %IFFT h(u,v)
                                 PSF = ifft2(fPSF);
                                 PSF = fftshift(abs(PSF));

                                 %filter deconvolucy pada proses deblurring dengan metoda RL (citra uji,psf,banyak iterasi)
                                 J= deconvlucy(GryImg,PSF,(jumlah iterasi));

                                 %pennigkatan kontras
                                 K = imadjust(J,stretchlim(J),[]);
                                 toc
%                                 figure(1);
%                                 imshow(K); title('Tahap 4 Stretching');
%                                 figure(2);
%                                 imshow(J); title('Tahap 4 Stretching');
                                 %menampilkan citra terolah
                                 %plot original image
                                 figure(1); 
                               imshow(TestImg); title('Citra Asli');
                               figure(2); 
                                 imshow(GryImg); title('Referensi');
                                 figure(3); 
                                  imshow(MedImg); title('Tahap 2 Median Filter');
                                  figure(4); 
                                 imshow(J); title('Tahap 3 Deblurring'); 
                                 figure(5); 
                                  imshow(K); title('Tahap 4 Stretching');
                                 
                                 figure(6); 
                                 imshow(K); title('Tahap 4 Stretching');
                                  figure(7); 
                                 imshow(PSF); title('PSF');
                                 
                                 %menghitung MSE,PSNR,SNR
                                %  n=size(TestImg);
                                %  M=n(1);
                                %  n(2);
                                %  MSE = sum(sum((GryImg - K).^2))/(M*N);
                                %  PSNR = 10*log10(256*256/MSE);
                                %  SNR = 20*log10 (256*256/MSE);
                                %  fprintf('\nMSE: %7.2f ', MSE);
                                %  fprintf('\nPSNR: %9.7f dB', PSNR);
                                %  fprintf('\nSNR: %9.7f dB', SNR);
                                 %tampilkan citra asli

