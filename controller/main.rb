# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class MainController < Controller
  helper :aspect

  before{
    if request.fullpath !~ %r{^/locale}
      if session[:LOCALE].nil?
        session[:referer] = request.fullpath
        redirect('/locale')

      else
        session.delete(:referer)

      end
    end
  }

  def index
    '[[locale_name]]'
  end

  def locale
    @locales = Ramaze::Tool::Localize.languages.map{ |lang|
      [
        Ramaze::Tool::Localize.localize('locale_menu_descrition', lang),
        Ramaze::Tool::Localize.localize('locale_name', lang),
        lang
      ]
    }
  end

  def locale_setup name
    session[:LOCALE] = name if Ramaze::Tool::Localize.languages.member?(name)
    redirect(session[:referer] || '/')
  end
end
