%%
% Betasort & BetaQ Single Session Simulation (all probabilities calculated)

% Assign Parameters
noise = 0.1;
remem = 0.9;

% Set Ip Trial Types
trials = 200;
adjacent_stims = [1 2;2 3;3 4;4 5;5 6;6 7];
all_stims = [1 2;1 3;1 4;1 5;1 6;1 7;2 3;2 4;2 5;2 6;2 7;3 4;3 5;3 6;3 7;4 5;4 6;4 7;5 6;5 7;6 7];
pairs = all_stims(:,1).*10 + all_stims(:,2);

task_stims = [];

% Adjacent Pair Trials
loop = ceil(trials/size(adjacent_stims,1));
sz = size(adjacent_stims,1);
for i = 1:loop
	task_stims = [task_stims;adjacent_stims(randperm(sz),:)];
end
task_stims = task_stims(1:trials,:);

% All Pair Trials
loop = ceil(trials/size(all_stims,1)) + trials;
sz = size(all_stims,1);
for i = 1:loop
	task_stims = [task_stims;all_stims(randperm(sz),:)];
end
task_stims = task_stims(1:trials.*2,:);

% Simulate Sessions
[c_b,r_b,UL_b,RN_b,p_b] = betasort_simulate(noise,remem,task_stims,pairs);
[c_bq,r_bq,UL_bq,RN_bq,p_bq] = betaQ_simulate(noise,remem,task_stims,pairs);

% Plot Response Accuracy For All Pairs
% Dashed Line		=	Chance
% Gray Background	=	Critical Transfer Pairs
% Filled Circles	=	Betasort Performance
% Open Circles		=	BetaQ Performance

subplot(1,2,1)
hold on
rectangle('Position',[8.5 0 3 1],'FaceColor',[0.9 0.9 0.9],'Edgecolor','none')
rectangle('Position',[14.5 0 2 1],'FaceColor',[0.9 0.9 0.9],'Edgecolor','none')
rectangle('Position',[19.5 0 1 1],'FaceColor',[0.9 0.9 0.9],'Edgecolor','none')
title('Performance Following Adjacent Pair Trials');
plot([0 29.9],[0.5 0.5],'--','Color','k')
plot([7 7],[0 1],'-','Color',[0.6 0.6 0.6])
plot([13 13],[0 1],'-','Color',[0.6 0.6 0.6])
plot([18 18],[0 1],'-','Color',[0.6 0.6 0.6])
plot([22 22],[0 1],'-','Color',[0.6 0.6 0.6])
plot([25 25],[0 1],'-','Color',[0.6 0.6 0.6])
ax = gca;
ax.XTick = [(1:6) (8:12) (14:17) (19:21) (23:24) 26];
ax.XTickLabel = {'AB', 'BC', 'CD', 'DE', 'EF', 'FG', 'AC', 'BD', 'CE', 'DF', 'EG', 'AD', 'BE', 'CF', 'DG', 'AE', 'BF', 'CG', 'AF', 'BG', 'AG'};

scatter([1:6],p_b(trials,[1 7 12 16 19 21]),50,[1 0 0],'filled')
scatter([8:12],p_b(trials,[2 8 13 17 20]),50,[0.9 0.5 0],'filled')
scatter([14:17],p_b(trials,[3 9 14 18]),50,[0.7 0.7 0],'filled')
scatter([19:21],p_b(trials,[4 10 15]),50,[0 0.6 0],'filled')
scatter([23:24],p_b(trials,[5 11]),50,[0 0 0.9],'filled')
scatter(26,p_b(trials,6),50,[0.9 0 0.9],'filled')

scatter([1:6],p_bq(trials,[1 7 12 16 19 21]),50,[1 0 0])
scatter([8:12],p_bq(trials,[2 8 13 17 20]),50,[0.9 0.5 0])
scatter([14:17],p_bq(trials,[3 9 14 18]),50,[0.8 0.8 0])
scatter([19:21],p_bq(trials,[4 10 15]),50,[0 0.6 0])
scatter([23:24],p_bq(trials,[5 11]),50,[0 0 0.9])
scatter(26,p_bq(trials,6),50,[0.9 0 0.9])
hold off

subplot(1,2,2)
hold on
rectangle('Position',[8.5 0 3 1],'FaceColor',[0.9 0.9 0.9],'Edgecolor','none')
rectangle('Position',[14.5 0 2 1],'FaceColor',[0.9 0.9 0.9],'Edgecolor','none')
rectangle('Position',[19.5 0 1 1],'FaceColor',[0.9 0.9 0.9],'Edgecolor','none')
title('Performance Following All Pair Trials');
plot([0 29.9],[0.5 0.5],'--','Color','k')
plot([7 7],[0 1],'-','Color',[0.6 0.6 0.6])
plot([13 13],[0 1],'-','Color',[0.6 0.6 0.6])
plot([18 18],[0 1],'-','Color',[0.6 0.6 0.6])
plot([22 22],[0 1],'-','Color',[0.6 0.6 0.6])
plot([25 25],[0 1],'-','Color',[0.6 0.6 0.6])
ax = gca;
ax.XTick = [(1:6) (8:12) (14:17) (19:21) (23:24) 26];
ax.XTickLabel = {'AB', 'BC', 'CD', 'DE', 'EF', 'FG', 'AC', 'BD', 'CE', 'DF', 'EG', 'AD', 'BE', 'CF', 'DG', 'AE', 'BF', 'CG', 'AF', 'BG', 'AG'};

scatter([1:6],p_b(trials.*2,[1 7 12 16 19 21]),50,[1 0 0],'filled')
scatter([8:12],p_b(trials.*2,[2 8 13 17 20]),50,[0.9 0.5 0],'filled')
scatter([14:17],p_b(trials.*2,[3 9 14 18]),50,[0.8 0.8 0],'filled')
scatter([19:21],p_b(trials.*2,[4 10 15]),50,[0 0.6 0],'filled')
scatter([23:24],p_b(trials.*2,[5 11]),50,[0 0 0.9],'filled')
scatter(26,p_b(trials.*2,6),50,[0.9 0 0.9],'filled')

scatter([1:6],p_bq(trials.*2,[1 7 12 16 19 21]),50,[1 0 0])
scatter([8:12],p_bq(trials.*2,[2 8 13 17 20]),50,[0.9 0.5 0])
scatter([14:17],p_bq(trials.*2,[3 9 14 18]),50,[0.8 0.8 0])
scatter([19:21],p_bq(trials.*2,[4 10 15]),50,[0 0.6 0])
scatter([23:24],p_bq(trials.*2,[5 11]),50,[0 0 0.9])
scatter(26,p_bq(trials.*2,6),50,[0.9 0 0.9])
hold off

%%
% Contents of Memory Demonstration

% Assign Parameters
noise = 0.1;
remem = 0.9;

% Set Ip Trial Types
trials = 200;
all_stims = [1 2;1 3;1 4;1 5;1 6;1 7;2 3;2 4;2 5;2 6;2 7;3 4;3 5;3 6;3 7;4 5;4 6;4 7;5 6;5 7;6 7];
pairs = all_stims(:,1).*10 + all_stims(:,2);

task_stims = [];

% All Pair Trials
loop = ceil((trials.*2)/size(all_stims,1));
sz = size(all_stims,1);
for i = 1:loop
	task_stims = [task_stims;all_stims(randperm(sz),:)];
end
task_stims = task_stims(1:trials.*2,:);

ULRN_mass = cell(400,3);
for i = 1:400
	for j = 1:3
		ULRN_mass{i,j} = zeros(1,7);
	end
end

UL = nan(7,2);
RN = zeros(7,2);
for t = 1:200
	c = betasort_choose(UL,task_stims(t,:),noise);
	if c == task_stims(t,1)
		r = 1;
		calt = task_stims(t,2);
	else
		r = 0;
		calt = task_stims(t,1);
	end
	RN = betasort_RN_update(RN,c,calt,r,remem);
	UL = betasort_UL_update(UL,RN,c,calt,r,remem);
	ULRN_mass{t,1} = ULRN_mass{t,1} + UL(:,1)';
	ULRN_mass{t,2} = ULRN_mass{t,2} + UL(:,2)';
	ULRN_mass{t,3} = ULRN_mass{t,3} + UL(:,1)'./(UL(:,1)'+UL(:,2)');
end
UL = UL([7;6;5;4;3;2;1],:);
RN = RN([7;6;5;4;3;2;1],:);
for t = 201:400
	c = betasort_choose(UL,task_stims(t,:),noise);
	if c == task_stims(t,1)
		r = 1;
		calt = task_stims(t,2);
	else
		r = 0;
		calt = task_stims(t,1);
	end
	RN = betasort_RN_update(RN,c,calt,r,remem);
	UL = betasort_UL_update(UL,RN,c,calt,r,remem);
	ULRN_mass{t,1} = ULRN_mass{t,1} + UL(:,1)';
	ULRN_mass{t,2} = ULRN_mass{t,2} + UL(:,2)';
	ULRN_mass{t,3} = ULRN_mass{t,3} + UL(:,1)'./(UL(:,1)'+UL(:,2)');
end
ULRN_mass = cell2mat(ULRN_mass(:,3));

subplot(1,2,1)
plot(ULRN_mass)
title('Betasort Stimulus Positions During On All Pairs Trials, With Reversal');

ULRN_mass = cell(400,3);
for i = 1:400
	for j = 1:3
		ULRN_mass{i,j} = zeros(1,7);
	end
end

UL = nan(7,2);
RN = zeros(7,2);
for t = 1:200
	c = betasort_choose(UL,task_stims(t,:),noise);
	if c == task_stims(t,1)
		r = 1;
		calt = task_stims(t,2);
	else
		r = 0;
		calt = task_stims(t,1);
	end
	RN = betaQ_RN_update(RN,c,calt,r,remem);
	UL = betaQ_UL_update(UL,RN,c,calt,r,remem);
	ULRN_mass{t,1} = ULRN_mass{t,1} + UL(:,1)';
	ULRN_mass{t,2} = ULRN_mass{t,2} + UL(:,2)';
	ULRN_mass{t,3} = ULRN_mass{t,3} + UL(:,1)'./(UL(:,1)'+UL(:,2)');
end
UL = UL([7;6;5;4;3;2;1],:);
RN = RN([7;6;5;4;3;2;1],:);
for t = 201:400
	c = betasort_choose(UL,task_stims(t,:),noise);
	if c == task_stims(t,1)
		r = 1;
		calt = task_stims(t,2);
	else
		r = 0;
		calt = task_stims(t,1);
	end
	RN = betaQ_RN_update(RN,c,calt,r,remem);
	UL = betaQ_UL_update(UL,RN,c,calt,r,remem);
	ULRN_mass{t,1} = ULRN_mass{t,1} + UL(:,1)';
	ULRN_mass{t,2} = ULRN_mass{t,2} + UL(:,2)';
	ULRN_mass{t,3} = ULRN_mass{t,3} + UL(:,1)'./(UL(:,1)'+UL(:,2)');
end
ULRN_mass = cell2mat(ULRN_mass(:,3));

subplot(1,2,2)
plot(ULRN_mass)
title('BetaQ Stimulus Positions During All Pairs Trials, With Reversal');




