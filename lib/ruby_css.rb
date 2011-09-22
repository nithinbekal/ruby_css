
module RubyCss
  
  class Selector
    
    attr_accessor :name, :properties, :children
    
    def initialize(name, &blk)
      @properties = {}
      @name = name.to_s
      @children = []
      instance_eval(&blk)
    end
      
    # Generates CSS for the given selector name.
    #
    # Example:
    # s('h1.title') { font_size '2em' }
    #
    # Generates:
    # h1.title {
    # font-size: 2em;
    # }
    #
    def s(selector_name, &blk)
      @children << Selector.new("#{@name} #{selector_name}", &blk)
    end
    
    # Generates CSS for a given ID.
    #
    # Example:
    # id('posts') { font_size '12px' }
    #
    # Generates:
    # #posts {
    # font-size: 12px;
    # }
    #
    def id(id_name, &blk)
      @children << Selector.new("#{@name} \##{id_name}", &blk)
    end
    
    # Generates CSS for a given class name.
    #
    # Example:
    # c('post') { font_size '12px' }
    #
    # Generates:
    # .post {
    # font-size: 12px;
    # }
    #
    def c(id_name, &blk)
      @children << Selector.new("#{@name} .#{id_name}", &blk)
    end
    
    # Handles generation of CSS for any HTML tag.
    #
    # Example:
    # nav { float 'right' }
    #
    # Generates:
    # nav {
    # float: right;
    # }
    #
    # TODO: Create selectors only for valid HTML tags.
    #
    def method_missing(method_name, *args, &blk)
      if block_given?
        @children << Selector.new([@name, method_name].join(' '), &blk)
      else
        @properties[method_name.to_s.sub('_', '-')] = args[0]
      end
    end
    
    # Generates the formatted output CSS as a string.
    #
    def to_s
      css = "#{@name} {\n"
      @properties.each_pair { |k, v| css += " #{k}: #{v};\n" }
      css += "}\n\n"
      @children.each { |c| css += c.to_s }
      css
    end
    
  end
  
  class Stylesheet
    
    def initialize(file)
      @__selectors = []
      instance_eval( File.read(file) )
    end
    
    def method_missing(method_name, *args, &blk)
      @__selectors << Selector.new(method_name, &blk) if block_given?
    end
    
    def to_css
      puts "\n\n"
      @__selectors.each do |s|
        puts s.to_s
      end
    end
    
  end
end
