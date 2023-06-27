% simulations using parameters fitted to the average of wt cPRC recordings using the wt model 
t_end=200;
frames = 0:0.05:t_end;

dur=[0.1 0.5 1:2:51];
n_dur=numel(dur);

amp=linspace(0.1,1,10);
n_amp=numel(amp);

for idx_dur=1:n_dur
    for idx_amp=1:n_amp
        uva_opt = @(x) simulate_prediction(x,6,dur(idx_dur),amp(idx_amp),1,t_end);
        
        % wt_mean_par have to be estimated 1st e.g. using a script fit_cprc_example.m
        C_PRC=uva_opt(wt_mean_par);
        
        clf
        patch([frames(101) frames(101+dur(idx_dur)/0.05) frames(101+dur(idx_dur)/0.05) frames(101)],...
              [min(C_PRC) min(C_PRC) max(C_PRC) max(C_PRC)],[0.49,0.18,0.56],'Facealpha',0.5,'linestyle','none')
        hold on

        plot(frames,C_PRC,'k','LineWidth',2);
        title(['Amp: ' num2str(amp(idx_amp),  2) ', Dur: ' num2str(dur(idx_dur),2)])
        ylim([1 max(C_PRC)+0.05*max(C_PRC)])
        xlim([0 140])
        pause
    end
end