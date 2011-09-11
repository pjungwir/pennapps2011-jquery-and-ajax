# Based on code found here:
# http://stackoverflow.com/questions/4487796/removing-utf8-from-rails-3-form-submissions
# For an explanation of the utf-8 checkmark, see here:
# http://stackoverflow.com/questions/3222013/what-is-the-snowman-param-in-rails-3-forms-for

module ActionView::Helpers::FormTagHelper
    private

    def extra_tags_for_form_with_snowman_excluded_from_gets(html_options)
        old = extra_tags_for_form_without_snowman_excluded_from_gets(html_options)
        if old.include?('"_method"')    # Not a GET request
            old
        else
            old.sub(/<[^>]+name="utf8"[^>]+"&#x2713;"[^>]*>/, '')
        end
    end
    alias_method_chain :extra_tags_for_form, :snowman_excluded_from_gets

end
