%=====================================================================
% The following code implments the Affine Structure from Motion using the 
% algorithm introduced by C. Tomasi and T. Kanade. in Shape and motion 
% from image streams under orthography: A factorization method. IJCV,
% 9(2):137-154, November 1992.
%=====================================================================

clear all;
close all;
%===================== Step 2a ==================================%
% Loading the measurement matrix....
measure = load('measurement_matrix.txt');
%===================== Step 2b ==================================%
% Normalizing the point coordinates by translating them to the mean of the
% points in each view
mom = mean(measure, 2); % taking the mean of the measurement matrix....
for i = 1: size(mom,1)
    measure(i, :) = ( measure(i, :) - mom(i, :) ); % Normalizing....
end
%===================== Step 3 ==================================%
% Apply SVD to the measurement matrix to express it as D = U * W * V'
% in order to derive the structure and motion matrices.
% where size of : U -> 202 x 3; W -> 3 x 3 (largest three singular values)
% and V -> 215 x 3.
[U,S,V] = svd(measure);
U = U(:,1:3);
W = S(1:3, 1:3);
V = V(:,1:3)';
% Motion matrix....
M = U * sqrtm(W);
% Structure matrix
S = (sqrtm(W) * V);
%===================== Step 4 ==================================%
% Using plot3 to display the 3D structure from several different angles. 
MS = M * S;
for i = 1: size(mom,1)
    measure(i, :) = ( measure(i, :) + mom(i) );
    MS(i, :) = ( MS(i, :) + mom(i) );
end

figure 
axis([ -6 2 -3 3 -10 -2])
hold on
plot3( S(1,:)', S(2,:)', S(3,:)', 'ok' )
hold off
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
%%-----------------------------------------------------------------
%% using Alan Jennings's code to create a video of the Reconstruction 
%% view rotating viewZ
%%-----------------------------------------------------------------
%OptionZ.FrameRate=15;OptionZ.Duration=5.5;OptionZ.Periodic=true;
%CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10],'Aff_Struc',OptionZ)
hold off;
%===================== Step 5 ==================================%
% Projecting the 3D points back into the images and calculating 
% the total mean square error over all the frames
FolderInfo_im  = dir('*.jpg');
for i = 1 : size(dir('*.jpg'),1)
	im_name = [FolderInfo_im(i).name];
	im = imread(im_name);
	frame = sscanf(im_name, '%*[^0123456789]%d');
	figure(2)
	imshow(im)
	hold on
	plot( measure( 2*i - 1, : )', measure( 2*i, : )', 'oc' ),
	plot( MS( 2*i - 1, : )', MS( 2*i, : )', 'or' ),
	axis equal
	grid on 
	legend('Given Measurements','Tracked 3D Points')
	hold off
	%mov(i)=getframe;
end
%movie(mov);



per_frame_residual = zeros(101, 1);
for i = 1:101
    for j = 1:size(measure,2)
        per_frame_residual(i,1) = per_frame_residual(i,1) + sqrt(sumsqr(MS(2*i-1:2*i, j) - measure(2*i-1:2*i, j))); 
    end
end

total_frame_residual = sum(per_frame_residual)

figure
hold on
plot( per_frame_residual, 'ob' )
axis([0 101 0 400]); grid on
hold off
title('Residuals (per frame) ')
xlabel('frame number');
ylabel('residules');
