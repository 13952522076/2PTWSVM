function Result = hibiscus(Label, Inst,v)% inst: 训练数据，Method:学习方法默认SSVM, Type:模式选择，默认UDRIndex = 1:length(Label);%即样本的个数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%k=1;        for i=-7:7            C1Grid(1,k)=i;            k=k+1;        end         [ic1] = GridExplore(Label, Inst, C1Grid,v);          Best_C1 = 2^C1Grid(1,ic1);    % Result structureResult.Best_C1 = Best_C1;%Result.Points = 2.^P;clear functions;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%function [ic1] = GridExplore(Label, Inst, C1,v)maxerror=200;[m1] = size(C1,2); TErr =0;VErr =0;flag = 0;for i=1:m1                 Model = K_svm_train(Label,Inst,2^C1(1,i),v);               VErr=Model.Err.Validation(1);                 if VErr<maxerror                maxerror=VErr;                ic1=i;ic2=j;            end        end