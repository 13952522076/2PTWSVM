clear;
dataset='heart'
load /Users/melody/Desktop/2PTWSVM/data/heart.mat;
B=A;
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear











clear;
dataset='australian'
load /Users/melody/Desktop/2PTWSVM/data/australian.mat;

B=A;
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear












clear;
dataset='blood'
load /Users/melody/Desktop/2PTWSVM/data/blood.mat;

B=[blood];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear












%---------------------------------------------------------------%
clear;
dataset='bupadata'
load /Users/melody/Documents/svm/twotypesData/wisconson/bupadata.mat;

B=[d A];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear






%---------------------------------------------------------------%
clear;
dataset='cancer'
load /Users/melody/Desktop/2PTWSVM/data/cancer.mat;

B=A;
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear

















%---------------------------------------------------------------%
clear;
dataset='checkdata'
load /Users/melody/Documents/svm/twotypesData/wisconson/checkdata.mat;

B=[d A];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear

















%---------------------------------------------------------------%
clear;
dataset='germ'
load /Users/melody/Desktop/2PTWSVM/data/germ.mat;

B=A;
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear













%---------------------------------------------------------------%
clear;
dataset='haberman'
load /Users/melody/Desktop/2PTWSVM/data/haberman.mat;

B=[haberman];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear















%---------------------------------------------------------------%
clear;
dataset='ionodata'
load /Users/melody/Desktop/2PTWSVM/data/ionodata.mat;

B=[d A];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear

















%---------------------------------------------------------------%
clear;
dataset='monk1'
load /Users/melody/Desktop/2PTWSVM/data/monk1.mat;

B=[test;train];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear













%---------------------------------------------------------------%
clear;
dataset='monk2'
load /Users/melody/Documents/svm/twotypesData/UCITWO/monk2.mat;

B=[test;train];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear


















%---------------------------------------------------------------%
clear;
dataset='monk3'
load /Users/melody/Documents/svm/twotypesData/UCITWO/monk3.mat;

B=[test;train];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear





















%---------------------------------------------------------------%
clear;
dataset='pimadata'
load /Users/melody/Desktop/2PTWSVM/data/pimadata.mat;

B=[d A];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear


















%---------------------------------------------------------------%
clear;
dataset='sonar'
load /Users/melody/Desktop/2PTWSVM/data/sonar.mat;
    
B=A;
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear

















%---------------------------------------------------------------%
clear;
dataset='spect'
load /Users/melody/Desktop/2PTWSVM/data/spect.mat;
    
B=[test; train];
cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear















%---------------------------------------------------------------%
clear;
dataset='ticdata'
load /Users/melody/Documents/svm/twotypesData/wisconson/ticdata.mat;

B=[d A];

cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear














%---------------------------------------------------------------%
clear;
dataset='wpbc'
load /Users/melody/Documents/svm/twotypesData/UCITWO/wpbc.mat;

B=[test;train];

cla=1;
A=B(1:end,2:end);
Max=max(max(A));
Min=min(min(A));
A=2*(A-Min)./(Max-Min)-1;%数据归一化（－1，1）之间
d=(B(1:end,1)==cla)*2-1; %改成－1 ，1
ker='linear';
%ker ='rbf'
k=5;output=1;
[sm sn]=size(A);
accuIter = 0;
cpu_time = 0;
indx = [0:k];
indx = floor(sm*indx/k);    %last row numbers for all 'segments'
% split trainining set from test set
trainCorr=0;
testCorr=0;
a=50;%input('the state=');
rand('state',a);
r=randperm(size(d,1));
d=d(r,:);
A=A(r,:); 
for i = 1:k
	Ctest = []; dtest = [];Ctrain = []; dtrain = [];
	Ctest  = A((indx(i)+1:indx(i+1)),:);
	dtest  = d(indx(i)+1:indx(i+1));
	Ctrain = A(1:indx(i),:);
	Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];
	dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',a);


    uniqued = unique(dtrain);
    outratio=0.2;
    nf=0.1;
    for jjk=1:size(uniqued,1) %%%%%%partion points of each class into k parts.
        Inde=(find(dtrain==uniqued(jjk,1)));
        randn('state',jjk*1000);
        % randn('state',a);
        outn=fix(size(Inde,1)*outratio);
        Mm= sqrt(1)*randn(outn,size(Ctrain,2));
        % Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/norm(Mm,'fro'))*Mm;
        Ctrain(Inde(1:outn,:),:)=Ctrain(Inde(1:outn,:),:)+nf*(norm(Ctrain(Inde(1:outn,:),:),'fro')/(norm(Mm,'fro')+eps))*Mm;
        % if jjk==1
        % tempdata=Ctrain(Inde(1:outn,:),:);
        % end
    end
    r=randperm(size(Ctrain,1));
    dtrain=dtrain(r,:);
    % r2=randperm(size(Ctrain,1));
    Ctrain=Ctrain(r,:);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
	tic
    options.MaxIter = 100000;
    svm_struct = svmtrain(Ctrain,dtrain, 'Options', options); 
    thistoc(i,1)=toc;
    Group = svmclassify(svm_struct,Ctest); 
    err = sum(Group~=dtest);
	tmpTestCorr(i,1)=1-err/length(Ctest(:,1));
	Group = svmclassify(svm_struct,Ctrain); 
    err = sum(Group~=dtrain);
	tmpTrainCorr(i,1)=1-err/length(Ctrain(:,1));
    if output==1
        fprintf(1,'________________________________________________\n');
        fprintf(1,'Fold %d\n',i);
        fprintf(1,'Training set correctness: %3.2f%%\n',tmpTrainCorr(i,1));
        fprintf(1,'Testing set correctness: %3.2f%%\n',tmpTestCorr(i,1));

        fprintf(1,'Elapse time: %10.4f\n',thistoc(i,1));
    end
end % end of for (looping through test sets)
     trainCorr = sum(tmpTrainCorr*100)/k;
     testCorr = sum(tmpTestCorr*100)/k;
     cpu_time=sum(thistoc);
if output == 1
    fprintf(1,'==============================================');
    fprintf(1,'\nTraining set correctness: %3.2f%%',trainCorr);
    fprintf(1,'\nTesting set correctness: %3.2f%%',testCorr);

    fprintf(1,'\nAverage cpu_time: %10.4f\n',cpu_time);
end
testcorrstd=std(100*tmpTestCorr,1)
clear
