vid=videoinput('winvideo',1,'MJPG_640x480');
isrunning(vid);
triggerconfig(vid, 'Manual');
% vid.FramesPerTrigger = 100;
start(vid);
trigger(vid);
% islogging(vid);
while(vid.FramesAcquired<=9999999)
    I=getsnapshot(vid);
    figure(1);imshow(I);
%     diff_im=imsubtract(I(:,:,1),rgb2gray(I));
    I2=rgb2hsv(I);
    i= I2(:,:,3); 
    light=i>=1;
    [BW,~]=edge(light,'canny');
    [junk,threshold] = edge(light,'canny');
    fudgeFactor=.5;
    BWs=edge(light,'canny',threshold*fudgeFactor);
    se90=strel('line',3,90);
    se0=strel('line',3,0);
    BWsdil=imdilate(BWs,[se90 se0]);
    BWdfill=imfill(BWsdil,'holes');
    BWnobord=imclearborder(BWdfill,4);
    k1=bwlabel(BWnobord);
    I5=~BWnobord;
    figure(2);imshow(I5);
    stats=regionprops(I5,['basic']);
    bw=im2bw(I);
% % [n,m]=size(stats);
% % if (bw==0)
% %     break;
% % else
% %     tmp=stats(1);
% %  for i=2:n
% %      if stats(i).Area>tmp.Area
% %          tmp=stats(i);
% %      end
% %  end
%  
% a=max(max(k1));  
% [labeled,numObjects]=bwlabel(BWnobord,4);
% data=regionprops(labeled,'all');
% % for i=1:1:a
% % data(i).Area ;
% % data(i).Perimeter;
% % end
% % A=[data.Area];B=[data.Perimeter];
% % [p,q]=size(A);
% % for x=1:1:q
% %     c(x)=4*pi*A(x)/B(x)^2;
% %     if c(x)>=0.45
% %         fprintf('无异常');
% %     else
% %         c(x)<=0.45
% %         fprintf('检测火焰面积');
% %         m=c(x);
% %         p=m/76800;
% %         fprintf('%2.2f%%', p*100);
% %            if  p>=0.05
% %                call=1
% %                fprintf('报警')
% %            else
% %                 call=0
% %                 fprintf('请检查');
% %            end
% %     end
% % end
% for i=1:1:a
% data(i).Area ;
% end
% allcellm=[data.Area];
% m=sum(allcellm);
% p=m/76800;
%  if  p>=0.05;
%      call=1
%      fprintf('%2.2f%%', p*100);
%      fprintf('报警');
%  else
%      call=0
%      fprintf('%2.2f%%', p*100);
%      fprintf('无异常');
end
stop(vid);
flushdata(vid);
clear all
