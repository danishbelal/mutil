%% |mutil.ModelWorkspace| - Access ModelWorkspace data through a convenient interface
%
%% Constructor
%
%   d = mutil.ModelWorkspace("Model");
%
% # Name of the Simulink Model (without the .slx extension)
%

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
% # Evaluates the expression in the Model Workspace.

%% Example: Retrieve element from ModelWorkspace
% The Value is read directly from the Model Workspace and assigning e.Value also
% updates the value in the Model Workspace.
d = mutil.ModelWorkspace("DemoModel");
e = d.ByName("ScalarParameter");
disp("Value of e before doubling it " + e.Value);

% The value can be read and written.  Lets multiply it by 2.
e.Value = 2 * e.Value;
disp("Value of e after doubling it " + e.Value);