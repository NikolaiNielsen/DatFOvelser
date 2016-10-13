function gui_osc
% A Function to control the oscillator program
% Creates a GUI with sliders for the necessary inputs, buttons to plot and close
% the GUI, an a plot of the oscillators fasespace.

% First the min-max variables:
MinSlider = [10 0 0 0 0 0];
MaxSlider = [500 10*pi 1 1 5 10];
names = {'n','t','gamma','eps','l','g'};
nMin = 10; nMax = 500;
tMin = 0; tMax = 10*pi;
gammaMin = 0; gammaMax = 1;
epsMin = 0; epsMax = 1;
lMin = 0; lMax = 5;
gMin = 0; gMax = 10;
driven = 0;
x = 1;
y = 0;
BGColor = [1/3 1/3 1/3];

f = figure('Visible','off',...
          'Color',BGColor,...
          'Position',[0,0,1000,700],...
          'Name','Oscillator with GUI');

movegui(f,'center');

% Creates all the sliders and text for these
for i = 1:length(MinSlider)
    UI_Slider{i} = uicontrol('Style','slider',...
            'Position', [30+50*(i-1),200,15,400],...
            'value',MinSlider(i),...
            'Min', MinSlider(i),...
            'Max', MaxSlider(i));
            %'Callback',@initOsc);

    % Grab the sliders position, so we don't have to change it all the time
    SPos = get(UI_Slider{i},'Position');

    UI_SliderTitle{i} = uicontrol('Style','text',...
            'Position', [SPos(1),SPos(2)-25,50,25],...
            'String',names{i},...
            'horizontalAlignment','left',...
            'BackgroundColor',BGColor,...
            'ForegroundColor','white');

    UI_SliderValue{i} = uicontrol('Style','text',...
            'Position', [SPos(1),SPos(2)+SPos(4),50,25],...
            'String',MinSlider(i),...
            'horizontalAlignment','left',...
            'BackgroundColor',BGColor,...
            'ForegroundColor','white');
end

UI_Axes = axes('Units','Pixels',...
            'Position', [SPos(1)+SPos(3)+100,100,500,500]);

% UI generation er færdig, så kan vi vise det hele.
set(f,'Visible','on')


end
