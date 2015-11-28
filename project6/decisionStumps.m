function [ tree ] = decisionStumps(X_tr, y_tr, W)
% calculate info gain
y3 = find(y_tr == 3);
y5 = find(y_tr == 1);
w3 = W(y3);
w5 = W(y5);
p3 = sum(w3)/sum(W);
p5 = sum(w5)/sum(W);
parent_entropy = -p3*log2(p3)-p5*log2(p5);
for i = 1:size(X_tr,2) % loop for each attribute
    C = unique(X_tr(:,i)); % get unique value of the attribute
    for k = 1:size(C,1)
        split = C(k,1);
        left_children = find(X_tr(:,i)<=C(k,1));
        right_children = find(X_tr(:,i)>C(k,1));
        lefty = y_tr(left_children);
        righty = y_tr(right_children);
        leftw = W(left_children);
        rightw = W(right_children);
        left1 = find(lefty == 1);
        right1 = find(righty == 1);
        pleft = sum(leftw(left1))/sum(leftw);
        pright = sum(rightw(right1))/sum(rightw);
        
        if pleft > (1-pleft)
            left_value(k,1) = 1;
        else
            left_value(k,1) = 3;
        end
        
        if pright > (1-pright)
            right_value(k,1) = 1;
        else
            right_value(k,1) = 3;
        end
        
        if pleft > 0 && pleft < 1
            left_entropy = -pleft*log2(pleft) - (1-pleft)*log2(1-pleft);
        else
            left_entropy = 0;
        end
        
        if pright > 0 && pright < 1
            right_entropy = -pright*log2(pright) - (1-pright)*log2(1-pright);
        else
            right_entropy = 0;
        end
        m(k,1) = abs(parent_entropy - sum(leftw) * left_entropy - sum(rightw) * right_entropy);
    end
    
    J(i,1) = max(m);
    maxid = find(m == max(m));
    SV(i,1) = C(maxid);
    Left(i,1) = left_value(maxid,1);
    Right(i,1) = right_value(maxid,1);
    clear m;
end
mj = find(J == max(J));
tree.id = mj;
tree.split_value = SV(mj,1); 
tree.leftside = Left(mj,1);
tree.rightside = Right(mj,1);

left = find(X_tr(:,mj) <= tree.split_value);
right = find(X_tr(:,mj) > tree.split_value);
lefty = y_tr(left);
righty = y_tr(right);
wleft = W(left);
wright = W(right);
preleft = find(lefty == tree.leftside);
preright = find(righty == tree.rightside);
tree.err = 1 - sum(wleft(preleft)) - sum(wright(preright));
end
