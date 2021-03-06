class ArticlesController < ApplicationController


  def index
    pin = []
    pin << params[:one] if params[:one].present?
    pin << params[:two] if params[:two].present?
    pin << params[:three] if params[:three].present?
    pin << params[:four] if params[:four].present?
    pin << params[:five] if params[:five].present?
    pin << params[:six] if params[:six].present?

    red = [
      '01','02','03','04','05','06','07','08','09','10','11',
      '12','13','14','15','16','17','18','19',
      '20','21','22','23','24','25','26','27',
      '28','29','30','31','32','33','34','35'
    ]
    red = red - pin
    red_size = pin.count > 0 ? (5 - pin.count) : 5
    @counts = []
    number = params[:number] ||= 10
    blue = ['01','02','03','04','05','06','07','08','09','10','11','12']

    number.to_i.times do |x|
      @counts << (pin + red.shuffle[0, red_size]).sort.join(" ") + " + " + blue.shuffle[0,2].sort.join(" ")
    end
    if params[:ref].present?
      ref = params[:ref]
      array = []
      @counts.each do |count|
        array << count if count.split("+ ").last == ref
      end
      @counts = array
    end
    return @counts
  end


end
