function w = tukeywin(n, r)
% TUKEYWIN Tukey window.
%
% MIT License
% Copyright (c) 2019-2020 Pablo Pizarro R.
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

error(nargchk(1, 2, nargin, 'struct')); %#ok<NCHKN>

% Default value for R parameter.
if nargin < 2 || isempty(r)
    r = 0.500;
end

[n, w, trivialwin] = check_order(n);
if trivialwin, return, end

if r <= 0
    w = ones(n, 1);
elseif r >= 1
    w = hann(n);
else
    t = linspace(0, 1, n)';
    % Defines period of the taper as 1/2 period of a sine wave.
    per = r / 2;
    tl = floor(per*(n - 1)) + 1;
    th = n - tl + 1;
    % Window is defined in three sections: taper, constant, taper
    w = [((1 + cos(pi/per*(t(1:tl) - per))) / 2); ones(th-tl-1, 1); ((1 + cos(pi/per*(t(th:end) - 1 + per))) / 2)];
end