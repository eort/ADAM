function [connectivity] = get_connected_electrodes(labels)
% function to obtain connectivity between electrodes
% uses some Fieldtrip functions (thanks guys)
% output describes for each electrode (rows) to which electrodes it is
% connected (columns)
% JJF, VU 2016
elec = ft_read_sens('plotting_1005.sfp');
[~, ~, tokeep] = intersect(labels,elec.label,'stable');
elec.chanpos = elec.chanpos(tokeep,:);
elec.elecpos = elec.elecpos(tokeep,:);
elec.label = elec.label(tokeep);
elec.type = 'eeg1020';
if sum(strcmpi(elec.label', labels)) ~= numel(labels)
    error('hmm, this should not happen. need to fix label order, get to work');
end
cfg = [];
cfg.elec = elec;
cfg.method = 'triangulation';
neighbours = ft_prepare_neighbours(cfg);
cfg = [];
cfg.channel = elec.label;
cfg.neighbours = neighbours;
cfg.connectivity = channelconnectivity(cfg);
connectivity = cfg.connectivity;
