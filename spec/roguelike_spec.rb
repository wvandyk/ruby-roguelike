require 'spec_helper'

describe Roguelike do

  context "Renderer" do

    it "should be able to setup an instance of the renderer" do
      Roguelike::Renderer::NcursesApi.should_receive(:new).and_return(mock 'ncursesapi', :setup => true)
      roguelike = Roguelike::Roguelike.new
    end

    it "should shutdown the renderer at exit" do
      ncursesapi = given_an_ncursesapi_instance
      roguelike = given_a_roguelike_instance
      when_i_do [->{ roguelike.quit }, then_( ->{ ncursesapi.should_receive(:destroy) } )]
    end
  end

  def given_an_ncursesapi_instance
    ncursesapi = mock 'ncursesapi', :setup => true
    Roguelike::Renderer::NcursesApi.stub(:new).and_return(ncursesapi)
    ncursesapi
  end

  def given_a_roguelike_instance
    Roguelike::Roguelike.new
  end

  def when_i_do(action)
    action.last.call
    action.first.call 
  end

  def then_(action)
    action
  end

end
