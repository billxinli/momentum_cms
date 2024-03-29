require_relative '../../test_helper'

class MomentumCms::SnippetTest < ActiveSupport::TestCase
  def setup
    @site = momentum_cms_sites(:default)
  end

  def test_fixture_validity
    MomentumCms::Snippet.all.each do |snippet|
      assert snippet.valid?
    end
  end

  def test_create
    assert_difference 'MomentumCms::Snippet.count' do
      MomentumCms::Snippet.create(
        label: 'Snippet Name',
        identifier: 'identifier',
        site: @site
      )
    end
    assert_no_difference 'MomentumCms::Snippet.count' do
      MomentumCms::Snippet.create(
        label: 'Snippet Name',
        identifier: 'identifier',
        site: @site
      )
    end
  end

  def test_assign_identifier
    assert_difference 'MomentumCms::Snippet.count' do
      MomentumCms::Snippet.create(
        label: 'Snippet Name',
        site: @site
      )
    end
  end

  def test_snippets_can_not_nest

    snippet = MomentumCms::Snippet.new(site: @site, label: 'foo', identifier: 'bar')

    snippet.value = 'FOO BAR'

    assert snippet.valid?

    snippet.value = '{% cms_snippet identifier:foo'

    refute snippet.valid?

    snippet.value = 'Nested tags {% cms_snippet identifier:foo %}'

    refute snippet.valid?


  end

end
