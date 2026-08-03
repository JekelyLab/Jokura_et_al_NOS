load best_pars
%% WT
idx_reorder_WT=[1 20 4 3 21 2 7 5 6 8 9 10 12 11 13 14 15 16 22 23 24 25 17 18 19];

lbl_WT = {'\delta_{C_P}','\kappa_{GC1,2}','\kappa_{UV}',...
 '\kappa_{GC1,1}','\kappa_S','\delta_B',...
 'B_0','\kappa_B','\delta_S',...
 '\kappa_{C_N}','\delta_{C_N}',...
 '\kappa_{N,1}','\delta_N','\kappa_{N,2}'...
 '\kappa_{S_{GC1}}','\delta_{S_{GC1}}',...
 '\kappa_{Nin,1}','\delta_{Nin,1}', ...
 '\kappa_{S_1}','\delta_{S_1}',...
 '\kappa_{S_2}','\delta_{S_2}',...
 '\kappa_{+,1}','\kappa_{+,2}','\delta_{Nin,2}'};

pars_WT = best_pars_WT(:,idx_reorder_WT);
[cr,p] = corr(pars_WT,pars_WT);

filtered_cr=cr.*(p<0.05)-eye(25);
filtered_cr(abs(filtered_cr)<1e-6)=NaN;

colormap(brewermap(5,'*RdBu'))
im=imagesc(filtered_cr,[-1 1]);
im.AlphaData=~isnan(filtered_cr);
grid on
set(gca,'tickdir','out','XTick',1:25,'YTick',1:25,...
    'XAxisLocation','top','XTickLabel',lbl_WT,'YTickLabel',lbl_WT)
axis square
colorbar
for idx1=1:25
    for idx2=1:25
        if ~isnan(filtered_cr(idx1,idx2))
        text(idx1,idx2,num2str(filtered_cr(idx1,idx2),2),...
            'FontSize',6,...
            'HorizontalAlignment','center','VerticalAlignment','middle')
        end
    end
end


%% KO
lbl_KO = {'\delta_{C_P}','\kappa_{UV}','\kappa_S','\delta_B','B_0','\delta_S'};
idx_reorder_KO=[1 4 3 2 6 5];
pars_KO = best_pars_KO(:,idx_reorder_KO);
[cr,p] = corr(pars_KO,pars_KO);

filtered_cr=cr.*(p<0.05)-eye(6);
filtered_cr(abs(filtered_cr)<1e-6)=NaN;

colormap(brewermap(5,'*RdBu'))
im=imagesc(filtered_cr,[-1 1]);
im.AlphaData=~isnan(filtered_cr);
grid on
set(gca,'tickdir','out','XTick',1:6,'YTick',1:6,...
    'XAxisLocation','top','XTickLabel',lbl_KO,'YTickLabel',lbl_KO)
axis square
colorbar
for idx1=1:6
    for idx2=1:6
        if ~isnan(filtered_cr(idx1,idx2))
        text(idx1,idx2,num2str(filtered_cr(idx1,idx2),3),...
            'HorizontalAlignment','center','VerticalAlignment','middle')
        end
    end
end

%% NO
lbl_NO = {'\delta_S','\kappa_{C_N}','\delta_{C_N}',...
          '\kappa_{N,1}','\kappa_{N,2}','\delta_N'};
idx_reorder_NO=[1 2 3 4 6 5];
pars_NO = best_pars_NO(:,idx_reorder_NO);
[cr,p] = corr(pars_NO,pars_NO);

filtered_cr=cr.*(p<0.05)-eye(6);
filtered_cr(abs(filtered_cr)<1e-6)=NaN;

colormap(brewermap(5,'*RdBu'))
im=imagesc(filtered_cr,[-1 1]);
im.AlphaData=~isnan(filtered_cr);
grid on
set(gca,'tickdir','out','XTick',1:6,'YTick',1:6,...
    'XAxisLocation','top','XTickLabel',lbl_NO,'YTickLabel',lbl_NO)
axis square
colorbar
for idx1=1:6
    for idx2=1:6
        if ~isnan(filtered_cr(idx1,idx2))
        text(idx1,idx2,num2str(filtered_cr(idx1,idx2),3),...
            'HorizontalAlignment','center','VerticalAlignment','middle')
        end
    end
end

%% INNOS Ca
lbl_innos_ca = {'\delta_S','\kappa_{C_N}','\delta_{C_N}'};
pars_INNOS = best_pars_INNOS;
[cr,p] = corr(pars_INNOS,pars_INNOS);

filtered_cr=cr.*(p<0.05)-eye(3);
filtered_cr(abs(filtered_cr)<1e-6)=NaN;

colormap(brewermap(5,'*RdBu'))
im=imagesc(filtered_cr,[-1 1]);
im.AlphaData=~isnan(filtered_cr);
grid on
set(gca,'tickdir','out','XTick',1:3,'YTick',1:3,...
    'XAxisLocation','top','XTickLabel',lbl_innos_ca,'YTickLabel',lbl_innos_ca)
axis square
colorbar
for idx1=1:3
    for idx2=1:3
        if ~isnan(filtered_cr(idx1,idx2))
        text(idx1,idx2,num2str(filtered_cr(idx1,idx2),3),...
            'HorizontalAlignment','center','VerticalAlignment','middle')
        end
    end
end

