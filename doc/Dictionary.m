%% |mutil.Dictionary| - Access data dictionaries through a convenient interface
%
%% Constructor
%
%   d = mutil.Dictionary("DictionaryFile.sldd");
%   d = mutil.Dictionary("DictionaryFile.sldd", Section);
%
% # Filename of the dictionary (including the .sldd extension)
% # Section of the dictionary to open. Can be omitted and defaults to
% "Design Data".
%
% The examples below imply that DemoDataDictionary.sldd is on the path.

%% Methods
%
%   ByName(Name)
%   ByName(Name, EnableProxy)
%
% # Name is a string with the name of the object to be retrieved
% # EnableProxy (default |true|) can be used to turn off Parameter proxying.  Parameters are
% the common use-case and their usage can be quite cumbersome without
% proxying.
%
%   evalin(Expression)
%
% # Evaluates the expression in the Dictionary section.

%% Example: Retrieve element from dictionary
% The Value is read directly from the dictionary and assigning e.Value also
% updates the value in the dictionary.
d = mutil.Dictionary("DemoDataDictionary.sldd");
e = d.ByName("ScalarParameter");
disp("Value of e before doubling it " + e.Value);

% The value can be read and written.  Lets multiply it by 2.
e.Value = 2 * e.Value;
disp("Value of e after doubling it " + e.Value);