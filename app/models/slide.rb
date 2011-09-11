class Slide < ActiveRecord::Base
  attr_accessible :name, :sort_order

  validates :name, :presence => true
  
  validates :sort_order, :presence => true,
                         :uniqueness => true

  scope :in_order, order('slides.sort_order')
  scope :in_reverse_order, order('slides.sort_order DESC')

  def self.next_sort_order
    s = last_slide
    s ? s.sort_order + 1 : 1
  end

  def to_param
    sort_order.to_s
  end

  def first_slide?
    not prev_slide
  end

  def last_slide?
    not next_slide
  end

  def prev_slide
    @prev_slide ||= Slide.where('slides.sort_order < ?', sort_order).
      in_reverse_order.first
  end

  def next_slide
    @next_slide ||= Slide.where('slides.sort_order > ?', sort_order).
      in_order.first
  end

  def self.first_slide
    Slide.in_order.first
  end

  def self.last_slide
    Slide.in_reverse_order.first
  end

  def swap_position(a, b)
    (a.sort_order, b.sort_order) = b.sort_order, a.sort_order
    a.save!
    b.save!
  end

  def move_up
    swap_position(self, prev_slide) if prev_slide
  end

  def move_down
    swap_position(self, next_slide) if next_slide
  end

end
