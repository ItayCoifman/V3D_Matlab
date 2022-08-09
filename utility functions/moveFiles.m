function moveFiles = moveFiles(from,destination,format,varargin)
%this function moves all files in specifice format from-folder, to destination-folder
%% inputs
p = inputParser;
addOptional(p,'copy',true);
%addOptional(p,'format','')
parse(p,varargin{:});
%format = p.Results.format;
%moves all the *format files from from to destination
listing = dir(fullfile(from,['*.' format]));
%for trials with more then single static trial
%staticInd = i;
for i = 1:length(listing)
    fileName = listing(i).name;
    path = fullfile(from,fileName);
    copyfile(path,[destination fileName])
    if ~p.Results.copy == true
        delete(path)
    end
end