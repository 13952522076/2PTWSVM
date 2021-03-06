function [ u ,distance,SChange,SCHA] = svc2( A,B,p,c1)
    




    e1 = ones(size(A,1),1);
    e2 = ones(size(B,1),1);
    H = [A e1];
    G = [B e2];
    I = diag(ones(size(H,2),1));
    %初始化u
    u = zeros(size(H,2),1);
    %u_new = -pinv(G)*(ones(size(G,1),1));
    %u_new = ones(size(H,2),1);
    [w1,w2,b1,b2] = TWSVC(A,B,c1,c1);
    u_new = [w1;b1];
    itear = 0;
    
    %存下距离的变化
    distance =zeros(100,1);
    SChange = zeros(100,1);
    SCHA = zeros(100,1);
    
    while norm(u-u_new)>0.0001 && itear<=100
        distance(itear+1,1) =  norm(u-u_new);
        u = u_new;
        S = norm(H*u).^(p-2);
        SChange(itear+1,1)=S;
        % S = 0.5*(p-2)*norm(H*u).^(p-2);

        %HH = G*(S*H'*H)^(-1)*G';
        gamma = 1e-7*speye(size(H,2));
        HH = G*inv(S*H'*H+gamma)*G';
        HH = (HH+HH')/2;
        AA = diag(e2) ;
        bb = c1*e2;
        alpha = quadprog(HH,-e2,AA,bb);
        %正则化因子
       
        u_new = -inv(S*H'*H+gamma)*G'*alpha;
        itear = itear+1
        if(itear>1)
        SCHA(itear-1,1) = abs(SChange(itear,1)-SChange(itear-1,1)) ; 
    end
    

end

