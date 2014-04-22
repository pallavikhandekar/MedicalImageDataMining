
bmpFiles = dir('C:/Users/sharanya/Desktop/training oo/*.JPG');
cd('C:/Users/sharanya/Desktop/training oo');



ji=1;
 g = xlsread('training.xls');
  
  for k = 1:length(bmpFiles)
      %
      
  filename = bmpFiles(k).name;
   RGB = imread(filename);
   
   %tn=graythresh(RGB);
   %RGB1=im2bw(RGB,.680);
   
    if ndims(RGB) == 3
        GRAY = rgb2gray(RGB);
   else
        GRAY = RGB;
    end
    
   GRAY = imresize(GRAY,[512 512]);
    
   [IDX] = otsu(GRAY,3);
   IDX = imresize(IDX,[512 512]);
   
      
   %%  SEGMENTATION
    
   for i=1:512
      for j=1:512
         if(IDX(i,j)<3)
               IDX1(i,j)=0;
         else
               IDX1(i,j)=IDX(i,j);
               
            end
                          
       end
   end
   
   %% REPLACING WITH ORIGINAL PIXELS FOR SEGMENTED PORTION
   
   for i=1:512
        for j=1:512
            if(IDX1(i,j)==3)
                    IDX2(i,j)=GRAY(i,j);
            end
                    
        end
   end

   %subplot(223);
   IDX2 = imresize(IDX2,[512 512]);
   
  %figure;
 % subplot(221);
  %imshow(GRAY);
  %title('Original Image');

   %% FEATURE EXTRACTION FROM SEGMENTED AREA
    for i = 1:5
       glcm = graycomatrix(IDX2,'NumLevels',16,'offset',[0 i]);
        glcm45 = graycomatrix(IDX2,'NumLevels',16,'offset',[-i i]);
        glcm90 = graycomatrix(IDX2,'NumLevels',16,'offset',[-i 0]);
        glcm135 = graycomatrix(IDX2,'NumLevels',16,'offset',[-i -i]);
 
        [R C] = size(glcm);
        Step(i) = sum(sum(glcm));
        Step45(i) = sum(sum(glcm45));
        Step90(i) = sum(sum(glcm90));
        Step135(i) = sum(sum(glcm135));
 
 
        Temp = graycoprops(glcm);
        Temp45 = graycoprops(glcm45);
        Temp90 = graycoprops(glcm90);
        Temp135 = graycoprops(glcm135);
         
        Variance(i) = Temp.Contrast;
        Variance45(i) = Temp45.Contrast;
        Variance90(i) = Temp90.Contrast;
        Variance135(i) = Temp135.Contrast;
 
        Correlation(i) = Temp.Correlation;
        Correlation45(i) = Temp45.Correlation;
        Correlation90(i) = Temp90.Correlation;
        Correlation135(i) = Temp135.Correlation;
               
        Entropy(i) = entropy(glcm);
        Entropy45(i) = entropy(glcm45);
        Entropy90(i) = entropy(glcm90);
        Entropy135(i) = entropy(glcm135);
 
        Energy(i) = Temp.Energy;
        Energy45(i) = Temp45.Energy;
        Energy90(i) = Temp90.Energy;
        Energy135(i) = Temp135.Energy;
 
        Homogeneity(i) = Temp.Homogeneity;
        Homogeneity45(i) = Temp45.Homogeneity;
        Homogeneity90(i) = Temp90.Homogeneity;
        Homogeneity135(i) = Temp135.Homogeneity;
 
        Moment(i) = 0;
        Moment45(i) = 0;
        Moment90(i) = 0;
        Moment135(i) = 0;
        for m = 1:R
            for n = 1:C
                Moment(i) = Moment(i) + ((m-n)^3 * glcm(m,n));
                Moment45(i) = Moment45(i) + ((m-n)^3 * glcm45(m,n));
                Moment90(i) = Moment90(i) + ((m-n)^3 * glcm90(m,n));
                Moment135(i) = Moment135(i) + ((m-n)^3 * glcm135(m,n));
            end
        end
 
        Inv_Var(i) = 0;
        Inv_Var45(i) = 0;
        Inv_Var90(i) = 0;
        Inv_Var135(i) = 0;
 
        for m = 1:R
            for n = 1:C
                if m ~= n                                          
                     Inv_Var(i) = Inv_Var(i) + (glcm(m,n) / (m-n)^2);
                     Inv_Var45(i) = Inv_Var(i) + (glcm45(m,n) / (m-n)^2);
                     Inv_Var90(i) = Inv_Var(i) + (glcm90(m,n) / (m-n)^2);
                     Inv_Var135(i) = Inv_Var(i) + (glcm135(m,n) / (m-n)^2);
                end
            end
        end
        
        NMoment(i) = 0;
        NMoment45(i) = 0;
        NMoment90(i) = 0;
        NMoment135(i) = 0;
        for m = 1:R
            for n = 1:C
                NMoment(i) = NMoment(i) + ((m-n)^4 * glcm(m,n));
                NMoment45(i) = NMoment45(i) + ((m-n)^4 * glcm45(m,n));
                NMoment90(i) = NMoment90(i) + ((m-n)^4 * glcm90(m,n));
                NMoment135(i) = NMoment135(i) + ((m-n)^4 * glcm135(m,n));
            end
        end
    end
    
       
       %How to write in Excel file? and naming the columns
        fid = fopen('ans1.txt', 'a+');
      fid1 = fopen('ans2.txt', 'a+');
       %fprintf(fid,'%s\t',num2str(name));
     % fprintf(fid,'%d,\n',g(ji,1)); 
     % fprintf(fid1,'%d\n',g(ji,1)); 
       % fprintf(fid, '%.2f,\t', Moment,Moment90,Moment45(5),Moment135(2),Moment135(5),Entropy45(2),Entropy45(3),Entropy45(4),Entropy45(5),Entropy90(1),Entropy90(4),Entropy135(2),Entropy135(3),Entropy135(4),Entropy135(5),Energy45(1),Energy135(1));
        fprintf(fid1, '%.2f\n', Moment,Moment90,Moment45(5),Moment135(2),Moment135(5),Entropy45(2),Entropy45(3),Entropy45(4),Entropy45(5),Entropy90(1),Entropy90(4),Entropy135(2),Entropy135(3),Entropy135(4),Entropy135(5),Energy45(1),Energy135(1));
       fprintf(fid, '%.2f,\t', Step,Step45,Step90,Step135,Variance,Variance45,Variance90,Variance135,Entropy,Entropy45,Entropy90,Entropy135,Energy,Energy45,Energy90,Energy135,Homogeneity,Homogeneity45,Homogeneity90,Homogeneity135,Moment,Moment45,Moment90,Moment135,Inv_Var,Inv_Var45,Inv_Var90,Inv_Var135);
     %  fprintf(fid1, '%.2f\n', NMoment,NMoment45,NMoment90,NMoment135,Correlation,Correlation45,Correlation90,Correlation135);
     % fprintf(fid, '%.2f\n', Moment(5),Moment(2),Moment90(1),Moment90(3),Moment90(2),Moment(4),Moment90(4),Moment(1),Moment(3),Moment90(5),Entropy90(1),Entropy90(4),Moment45(5),Moment135(5),Entropy45(4),Entropy45(5),NMoment(5),Entropy135(5),Moment135(2),Entropy135(4),Entropy45(3),Entropy135(2),NMoment(4),Entropy135(3),NMoment(3),Entropy45(2),NMoment(2),NMoment(1),Energy135(1),Energy45(1));
      %fprintf(fid1, '%.2f,\t', Step,Step45,Step90,Step135,Variance,Variance45,Variance90,Variance135,Entropy,Entropy45,Entropy90,Entropy135,Energy,Energy45,Energy90,Energy135,Homogeneity,Homogeneity45,Homogeneity90,Homogeneity135,Moment,Moment45,Moment90,Moment135,Inv_Var,Inv_Var45,Inv_Var90,Inv_Var135,NMoment,NMoment45,NMoment90,NMoment135,Correlation,Correlation45,Correlation90,Correlation135);
        fprintf(fid,'%d',g(ji,2)); 
     fprintf(fid1,'%d',g(ji,2)); 
         fprintf(fid,'\n'); 
       fprintf(fid1,'\n'); 
       fclose(fid);
      fclose(fid1);
       ji=ji+1;
       %fid1=fopen('val.xls','a+');
       %xlswrite('val1',[Step,Step45,Step90,Step135,Variance,Variance45,Variance90,Variance135,Entropy,Entropy45,Entropy90,Entropy135,Energy,Energy45,Energy90,Energy135,Homogeneity,Homogeneity45,Homogeneity90,Homogeneity135,Moment,Moment45,Moment90,Moment135,Inv_Var,Inv_Var45,Inv_Var90,Inv_Var135,g(ji,2)]);
       
       
  end
  cd('..');
      % 
      % xlswrite('sampl.xls',Step);
       
  