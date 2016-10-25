function gui_osc
    % A Function to control the oscillator program
    % Creates a GUI with sliders for the necessary inputs, buttons to plot and close
    % the GUI, an a plot of the oscillators fasespace.

    % First the min-max variables:
    names = {'n','t','gamma','eps','l','g'};
    nMin = 10; nMax = 500;
    tMin = 0; tMax = 10*pi;
    gammaMin = 0; gammaMax = 1;
    epsMin = 0; epsMax = 1;
    lMin = 1; lMax = 5;
    gMin = 1; gMax = 10;
    MinSlider = [nMin tMin gammaMin epsMin lMin gMin];
    MaxSlider = [nMax tMax gammaMax epsMax lMax gMax];
    driven = 0;
    x = 1;
    y = 0;
    BGColor = [1/3 1/3 1/3];
    FontFace = 'Comic Sans MS'

    f = figure('Visible','off',...
            'Color',BGColor,...
            'Position',[0,0,1000,700],...
            'Name','Oscillator with GUI');

    movegui(f,'center');
    UI_Title = uicontrol('style','text',...
            'Position',[400,620,200,40],...
            'String','Oscillator gui.',...
            'horizontalAlignment','left',...
            'BackgroundColor',BGColor,...
            'ForegroundColor','white',...
            'FontSize',16,...
            'FontName',FontFace);
    % Creates all the sliders and text for these
    for i = 1:length(MinSlider)
        UI_Slider{i} = uicontrol('Style','slider',...
            'Position', [30+50*(i-1),200,15,400],...
            'value',MinSlider(i),...
            'Min', MinSlider(i),...
            'Max', MaxSlider(i),...
            'Callback',@updateSliders);

        % Grab the sliders position, so we don't have to change it all the time
        SPos = get(UI_Slider{i},'Position');

        UI_SliderTitle{i} = uicontrol('Style','text',...
            'Position', [SPos(1),SPos(2)-25,50,25],...
            'String',names{i},...
            'horizontalAlignment','left',...
            'BackgroundColor',BGColor,...
            'ForegroundColor','white',...
            'FontName',FontFace);

        UI_SliderValue{i} = uicontrol('Style','text',...
            'Position', [SPos(1),SPos(2)+SPos(4),50,25],...
            'String',MinSlider(i),...
            'horizontalAlignment','left',...
            'BackgroundColor',BGColor,...
            'ForegroundColor','white',...
            'FontName',FontFace);
    end

    % Lav en radioknap til driven
    UI_radio = uicontrol('style','radiobutton',...
            'Position', [SPos(1),SPos(2)-50,20,20],...
            'BackgroundColor',BGColor)
    UI_radioText = uicontrol('style','text',...
            'Position', [SPos(1)-40,SPos(2)-53,40,20],...
            'String','driven',...
            'BackgroundColor',BGColor,...
            'ForegroundColor','white',...
            'FontName',FontFace)

    % Lav en plotknap
    UI_pushplot = uicontrol('style','pushbutton',...
            'String','Plot',...
            'Position',[30,SPos(2)-50,40,20],...
            'Callback',@plotstuff,...
            'FontName',FontFace)



    % Lav et plotområde
    UI_Axes = axes('Units','Pixels',...
            'Position', [SPos(1)+SPos(3)+100,100,500,500]);



    % UI generation er færdig, så kan vi vise det hele.
    set(f,'Visible','on')


    function plotstuff(hObjekt, eventdata)
        % names = {'n','t','gamma','eps','l','g'};
        % UI_Slider{i} = uicontrol('Style','slider',...
        n = get(UI_Slider{1},'Value');
        t = get(UI_Slider{2},'Value');
        gam = get(UI_Slider{3},'Value');
        epsilon = get(UI_Slider{4},'Value');
        l = get(UI_Slider{5},'Value');
        g = get(UI_Slider{6},'Value');
        driven = get(UI_radio,'Value');
        x = ones(n+1,1);
        y = x;
        x(1) = 1;
        y(1) = 0;
        dx = x;
        dy = x;
        omega = sqrt(g/l);
        dt = t/n;

        if driven == 1
            d = @(x,y) y*(epsilon-x.^2)-x*omega^2;
        elseif driven == 0
            d = @(x,y) -gam*y-omega^2*x;
        end

        nextstep = @(x,dx1,dx0) x+(1.5*dx1-0.5*dx0)*dt;
        dx(2) = y(1);
        dy(2) = d(x(1),y(1));
        x(2) = x(1)+dx(2)*dt;
        y(2) = y(1)+dy(2)*dt;

        for i = 3:n+1
            dx(i) = y(i-1);
            dy(i) = d(x(i-1),y(i-1));
            x(i) = nextstep(x(i-1),dx(i),dx(i-1));
            y(i) = nextstep(y(i-1),dy(i),dy(i-1));
        end
        plot(x,y)
    end

    function updateSliders(hObjekt,eventdata)
        for i = 1:length(MinSlider)
            val = get(UI_Slider{i},'Value');
            set(UI_SliderValue{i},'string',val)
        end
    end
end
