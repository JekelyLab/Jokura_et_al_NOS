% load best_pars
figure(1)
par_lbl={'\delta_{C_P}','\delta_B','\kappa_S','\kappa_{UV}',...
         '\delta_S','B_0',...
         '\kappa_{C_N}','\delta_{C_N}',...
         '\kappa_{N,1}','\delta_N','\kappa_{N,2}'};

disp_ord = [1 4 3 2 6 5 7 8 9 11 10];

tiledlayout(3,4,'Padding','tight','TileSpacing','tight')
idx_par=[1:4 6:12];

fit_to_mean_part=[0.4639    0.0528    1.8346    0.7406...
                  0.2621    0.6036 ...
                  0.1360    0.5933 ...
                  7.5705   45.0318    0.1775];

for i=1:11
    nexttile
    struct.mdl1=best_pars_WT(:,idx_par(disp_ord(i)));
    
    if i<7
        struct.mdl2=best_pars_KO(:,disp_ord(i));
        violin_structure=my_violinplot(struct);
        violin_structure(1).ViolinColor=[0.72 0.27 1];
        violin_structure(2).ViolinColor='#edb120';
        hold on
        plot([0.75 2.25],[fit_to_mean_part(disp_ord(i)) fit_to_mean_part(disp_ord(i))],'--','linewidth',3,'Color',[0.25 0.25 0.25])
        title(par_lbl{disp_ord(i)})
        set(gca,'XTicklabel',{'WT cPRC','KO cPRC'})
        axis square
        grid on
    elseif i>6 && i<9 
        struct.mdl2=best_pars_INNOS(:,disp_ord(i)-6);
        violin_structure=my_violinplot(struct);
        violin_structure(1).ViolinColor=[0.72 0.27 1];
        violin_structure(2).ViolinColor=[0 0.45 0.74];
        hold on
        plot([0.75 2.25],[fit_to_mean_part(disp_ord(i)) fit_to_mean_part(disp_ord(i))],'--','linewidth',3,'Color',[0.25 0.25 0.25])
        title(par_lbl{disp_ord(i)})
        set(gca,'XTicklabel',{'WT cPRC','INNOS'})
        axis square
        grid on
    elseif i>8
        struct.mdl2=best_pars_NO(:,disp_ord(i)-8);
        violin_structure=my_violinplot(struct);
        violin_structure(1).ViolinColor=[0.72 0.27 1];
        violin_structure(2).ViolinColor=[70 152 117]./256;
        hold on
        plot([0.75 2.25],[fit_to_mean_part(disp_ord(i)) fit_to_mean_part(disp_ord(i))],'--','linewidth',3,'Color',[0.25 0.25 0.25])
        title(par_lbl{disp_ord(i)})
        set(gca,'XTicklabel',{'WT cPRC','WT NO'})
        axis square
        grid on
    else
        struct.mdl2=NaN; 
    end

   
end
%%
figure(2)
clf
idx_pars=[5 13:16 18:26];
fit_to_mean_part=[34.9330    0.2934    2.9941    1.8258...
               0.5540    0.0552    0.4558...
               0.2006   25.3012    3.1420    2.5891...
               0.1001    0.4717    0.1004];

par_lbl={'\kappa_B','\kappa_{S_{GC1}}','\delta_{S_{GC1}}','\kappa_{Nin,1}','\delta_{Nin,1}', ...
         '\kappa_{+,1}','\kappa_{+,2}','\delta_{Nin,2}','\kappa_{GC1,1}','\kappa_{GC1,2}', ...
         '\kappa_{S_1}','\delta_{S_1}','\kappa_{S_2}','\delta_{S_2}'};
disp_ord = [3 4 5 6 7 12 13 14 1 2 8 9 10 11];
[~,idx_sort]=sort(disp_ord);

tiledlayout(4,4,'Padding','tight','TileSpacing','tight')
for i=1:14
    if i<4
        nexttile(i)
    else
        nexttile(i+1)
    end
    violin_structure=my_violinplot(best_pars_wt(:,idx_pars(idx_sort(i))));
    violin_structure(1).ViolinColor=[0.72 0.27 1];
    hold on
    plot([0.75 1.25],[fit_to_mean_part(idx_sort(i)) fit_to_mean_part(idx_sort(i))],'--','linewidth',3,'Color',[0.25 0.25 0.25])
    title(par_lbl{idx_sort(i)})
    par_lbl{idx_sort(i)}
    set(gca,'XTicklabel',{'WT cPRC'})
    grid on
    axis square
    pause,
end
