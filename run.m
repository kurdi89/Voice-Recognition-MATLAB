%% clear 
clear;
clc;
%% Loading people voices: 
people = {'Obama', 'Blair', 'Trump'};
% loop through ppl and folders to load voices files : 
DataSet = cell(0, 0);
for p = 1:length(people)
    person = people{p};
    % loop through files : 
    files = dir( fullfile(person,'*.mp3'));
    for i=1:length(files)
        a = files(i).folder;
        b = files(i).name;
        fullname = fullfile(files(i).folder, files(i).name);
        [y,Fs] = audioread(fullname);
        % create the DataSet File :
        s = size(DataSet); z = s(1)+1;
        DataSet{z,1} = y;
        DataSet{z,2} = Fs;
        DataSet{z,3} = a;
        DataSet{z,4} = b;
        DataSet{z,5} = person;
    end
end
%% Create the data for training : 
% Generate samples from voices : 
x = size(DataSet);
for i = 1:x(1)
    % taking a sample of the voice :
    g = DataSet(i,1);
    c = g{1,1}';
    sample = c(1,100001:200000);
    %DataSet(i,5) is the person name 
    index = find(strcmp(people, DataSet(i,5))); % finding the index from ppl array
    Data(i,:) = [index, sample(1,:)];
end
%% Create a table : 
Table = array2table(Data);
%% test last file plot and play:
obj = audioplayer(y, Fs);
plot(y)
length(y)
obj.TimerPeriod = 1;
play(obj);
