function model=K_svm_train(label, Inst,p, C1,v) model = svm(label,Inst,p,C1,v);%==========================================================================VErrList=0; TErrList=0;function model=svm(d,A,p,C1,v)    [sm sn]=size(A);    indx = [0:v];    indx = floor(sm*indx/v);    for i = 1:v        Ctest = []; dtest = [];Ctrain = []; dtrain = [];        Ctest = A((indx(i)+1:indx(i+1)),:);        dtest = d(indx(i)+1:indx(i+1));        Ctrain = A(1:indx(i),:);        Ctrain = [Ctrain;A(indx(i+1)+1:sm,:)];        dtrain = [d(1:indx(i));d(indx(i+1)+1:sm,:)];        r=find(dtrain>0);        r1=setdiff(1:length(Ctrain(:,1)),r);        Y1=dtrain(r,:);        Y2=dtrain(r1,:);        cc=Ctrain(r,:);        dd=Ctrain(r1,:);        %[w1,w2,bias1,bias2]=svc(cc,dd,C1);        [u1]=svc(cc,dd,p,C1);        [u2]=svc(dd,cc,p,C1);        [w1]=u1(1:end-1,1);        [bias1]=u1(end,1);        [w2]=u2(1:end-1,1);        [bias2]=u2(end,1);        [err ]= svcerror(w1,w2,bias1,bias2,Ctest,dtest);        VErrList(i)=err/length(Ctest(:,1));        [err ]= svcerror(w1,w2,bias1,bias2,Ctrain,dtrain);        TErrList(i)=err/length(Ctrain(:,1));    end       model.Err.Training=mean(TErrList);    model.Err.Validation=mean(VErrList);                      