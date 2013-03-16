module Ajaila
  self.extend Ajaila

  def to_growth(p1,p2)
    p1, p2 = p1.to_f, p2.to_f
    return (p1 != 0 and p2 != 0)? p2/p1 - 1 : 0
  end

  ##
  # Normalize array
  def normalize(array)
    min, max = array.min, array.max
    more = lambda { |a| d = 1/(max-min).to_f; a.map { |el| (el-min)*d } }
    return min < max ? more.call(array) : array.fill(1.0)
  end

  def detect_nil(input, quit = 0)
    raise "Ajaila: Found Nil value among input values." if input == nil and quit == 0
    return input if input != nil
    return 0.0 if input == nil && (quit == 1 or quit == :quit)
  end

  def execute_miner(name)
    system "ajaila run miner #{name}"
  end

  def execute_selector(name)
    system "ajaila run selector #{name}"
  end

  def all_days_at_interval(time_start, time_end)
    output = []
    while time_start < time_end
      output << time_start
      time_start = time_start + 60 * 60 * 24
    end
    return output
  end

  def one_day
    return 60 * 60 * 24
  end

 def linear_plot(sample, opts = {})
    chart_title = (opts[:plot_name] == nil)? "Untitled Plot" : opts[:plot_name]
    line_title = (opts[:graph_name] == nil)? "some data" : opts[:graph_name]
    color = (opts[:color] == nil)? "blue" : opts[:color]
    w = (opts[:width] == nil)? 850 : opts[:width]
    h = (opts[:height] == nil)? 400 : opts[:height]

    i = 0
    data = sample.map do |item|
      i += 1
      OpenStruct.new({:x=> i, :y=> item})
    end
    
    vis = pv.Panel.new().width(200).height(200);
    
    
    x = pv.Scale.linear(data, lambda {|d| d.x}).range(0, w)
    w = 850
    h = 400  
    y = pv.Scale.linear(sample.min, sample.max).range(0, h);
    
    #/* The root panel. */
    vis = pv.Panel.new().width(w).height(h).bottom(20).left(20).right(40).top(5)
    
    #/* X-axis ticks. */
    vis.add(pv.Rule)
        .data(x.ticks())
        .visible(lambda {|d|  d > 0})
        .left(x)
        .strokeStyle("#eee")
      .add(pv.Rule)
        .bottom(-5)
        .height(5)
        .strokeStyle("#000")
      .anchor("bottom").add(pv.Label)
      .text(x.tick_format)
    
    #/* Y-axis ticks. */
    vis.add(pv.Rule)
        .data(y.ticks(5))
        .bottom(y)
        .strokeStyle(lambda {|d| d!=0 ? "#eee" : "#000"})
      .anchor("left").add(pv.Label)
      .text(y.tick_format);
    
    #/* The line. */
    vis.add(pv.Line)
        .data(data)
        .interpolate("step-after")
        .left(lambda {|d| x.scale(d.x)})
        .bottom(lambda {|d| y.scale(d.y)})
        .strokeStyle(color)
        .lineWidth(1);
    
    vis.render();
    
    output = %Q{
                  <h2>#{chart_title}</h2>
                  <p><span style = "color: #{color}">#{line_title}</span></p>
                  #{vis.to_svg}
                }
    return output
  end



end
