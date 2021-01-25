%% EE 183DA pset0
% Iou-Sheng (Danny) Chang
% UID: 804-743-003
clc; clear all; close all;

%% 5(a)
% Write a function that takes in 2 parameters:
%   the type of coin (fair or biased), and
%   the number of flips;
% and returns the resulting simulated sequence of outcomes. 
% Generate 10 sequences of 40 flips each:
% 5 sequences for a fair coin and 5 sequences for a biased coin.

% 5 sequences of Fair Coin
seqFairOutcome = cf(1,40,5);
% 5 sequences of Biased Coin
seqBiasedOutcome = cf(2,40,5);

%% 5(b)
% Modify that function to also calculate the likelihood that the coin is biased after each successive flip
% given the conditions of problem 4(c).

% 5 sequences of Fair Coin
[seqFO_b,likeFO_b] = cfl(1,40,5);
% 5 sequences of Biased Coin
[seqBO_b,likeBO_b] = cfl(2,40,5);

%% 5(c)
% Generate a properly labeled graph plotting the likelihood of having picked a biased coin
% as it evolves after each of 100 simulated flips of a fair coin
% Overlay 5 independent simulations on the same graph
[seqFO_c,likeFO_c] = cfl(1,100,5);
figure(1);
for i = 1:5
    plot(1:100,likeFO_c(i,:));
    hold on;
end
hold off;
legend({'$1^{st}\ sequence$','$2^{nd}\ sequence$','$3^{rd}\ sequence$','$4^{th}\ sequence$','$5^{th}\ sequence$'},'interpreter','latex','location','northeast');
title('$Likelihood\ of\ having\ picked\ a\ biased\ coin\ as\ it\ evolves\ after\ each\ of\ 100\ simulated\ flips\ of\ a\ fair\ coin$','interpreter','latex');
xlabel('$number\ of\ flips$','interpreter','latex');
ylabel('$P[picked\ a\ biased\ coin]$','interpreter','latex');
set(gca,'ticklabelinterpreter','latex');
grid on; box on;

%% 5(d)
% Generate a similar graph
% this time plotting 5 independent runs of simulating 100 flips of a biased coin
[seqFO_d,likeFO_d] = cfl(2,100,5);
figure(2);
for i = 1:5
    plot(1:100,likeFO_d(i,:));
    hold on;
end
hold off;
legend({'$1^{st}\ sequence$','$2^{nd}\ sequence$','$3^{rd}\ sequence$','$4^{th}\ sequence$','$5^{th}\ sequence$'},'interpreter','latex','location','northeast');
title('$Likelihood\ of\ having\ picked\ a\ biased\ coin\ as\ it\ evolves\ after\ each\ of\ 100\ simulated\ flips\ of\ a\ biased\ coin$','interpreter','latex');
xlabel('$number\ of\ flips$','interpreter','latex');
ylabel('$P[picked\ a\ biased\ coin]$','interpreter','latex');
set(gca,'ticklabelinterpreter','latex');
grid on; box on;

%% Functions
% Added another input parameters for ease of use (number of sequences we want to generate)

% 5(a)
    % Function Input Parameters:
        % type(1 == Fair, 2 == Biased)
        % numFlip == number of flips for each generated sequence
        % numSeq == number of sequences we simulate for each (Fair/Biased) Coin
    % Function Output Parameters:
        % seq == The generated sequence (each row in the matrix is 1 sequence)
function seq = cf(type,numFlip,numSeq)
    switch type
        % Type == Fair
        case 1
            seq = randi([0 1],numSeq,numFlip);
            disp(seq);
        % Type == Biased
            % P[H] = 0.25
        case 2
            seq = (rand(numSeq,numFlip) < 0.25);
            disp(seq);
        otherwise
            disp('Input Argument is Invalid, Please Re-Enter');
    end
end

% 5(b)
    % Function Input Parameters:
        % type(1 == Fair, 2 == Biased)
        % numFlip == number of flips for each generated sequence
        % numSeq == number of sequences we simulate for each (Fair/Biased) Coin
    % Function Output Parameters:
        % seq == The generated sequence (each row in the matrix is 1 sequence)
        % like == likelihood after each successive flip (nth row in the matrix is the likelihood for the nth sequence)
function [seq,like] = cfl(type,numFlip,numSeq)
    switch type
        % Type == Fair
        case 1
            seq = randi([0 1],numSeq,numFlip);
            disp(seq);
            for i = 1:numSeq
                pFair = 3/4;    % 3 Fair coins
                pBiased = 1/4;  % 1 Biased coin
                for j = 1:numFlip
                    pFair = pFair*(1/2);
                    % Head
                    if seq(i,j) == 1
                        pBiased = pBiased*(1/4);
                    % Tail
                    else
                        pBiased = pBiased*(3/4);
                    end
                    like(i,j) = pBiased/(pBiased+pFair);
                end
            end
            disp(like);
        % Type == Biased
            % P[H] = 0.25
        case 2
            seq = (rand(numSeq,numFlip) < 0.25);
            disp(seq);
            for i = 1:numSeq
                pFair = 3/4;    % 3 Fair coins
                pBiased = 1/4;  % 1 Biased coin
                for j = 1:numFlip
                    pFair = pFair*(1/2);
                    % Head
                    if seq(i,j) == 1
                        pBiased = pBiased*(1/4);
                    % Tail
                    else
                        pBiased = pBiased*(3/4);
                    end
                    like(i,j) = pBiased/(pBiased+pFair);
                end
            end
            disp(like);
        otherwise
            disp('Input Argument is Invalid, Please Re-Enter');
    end
end