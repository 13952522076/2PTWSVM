function Result = hibiscus9(Label, Inst,v)% inst: �???��?Method:�???��?�??SSVM, Type:�??模�?�??UD    RIndex = 1:length(Label);%?��?�??%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    C1Grid=-12:1:7;    pGrid = 0.9;             [ic1] = GridExplore(Label, Inst,pGrid, C1Grid,v);          Best_C1 = 2^C1Grid(1,ic1);    Best_p = pGrid;  % Result structureResult.Best_C1 = Best_C1;Result.Best_p = Best_p;%Result.Points = 2.^P;clear functions;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%function [ic1] = GridExplore(Label, Inst,pGrid, C1,v)maxerror=200;[m1] = size(C1,2); [mp] = size(pGrid,2); TErr =0;VErr =0;flag = 0;for i=1:m1            Model = K_svm_train(Label,Inst,pGrid,2^C1(1,i),v);           %Model = K_svm_train(Label,Inst,2,2^C1(1,i),v);           VErr=Model.Err.Validation(1);        if VErr<maxerror                maxerror=VErr;                ic1=i;                        end                   end