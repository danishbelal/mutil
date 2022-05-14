%% |mutil.Filter| - A handy function to filter lists, i.e. keep only elements of interest.

%% Syntax
%
%   List = mutil.Filter(List, Functor);
%
% # |List| is the list to be filterted
% # |Functor| is a function handle.  The function is expected to be a so
% called _predicate_, that means it takes a single element of the list and
% returns either true or false.

%% Example: Keep only even numbers
% Create a list with all numbers from 1 to 10 and remove all uneven numbers
% from it.
Numbers = 1:10;
disp(Numbers);
Numbers = mutil.Filter(Numbers, @(n) mod(n,2) == 0);
disp(Numbers);

%% Example: Filter a list of files
% Assume that you have a list of files in a directory and you want to deal
% only with Matlab script files (.m extension).  You can filter for them:
Files = ["Script.m", "Script.asv", "OtherScript.m", "Model.slx"];
MFiles = mutil.Filter(Files, @(f) endsWith(f, ".m"));
disp(MFiles);
%%
% Side-note for attentive readers: determining the file extension should
% usually done with the function <matlab:doc('fileparts') fileparts>.  However it cannot be used in
% this case, because multiple return value functions are incompatible with
% anonymous functions.