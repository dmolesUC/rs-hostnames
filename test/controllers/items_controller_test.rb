require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_url, params: { item: { name: @item.name } }
    end

    assert_redirected_to item_url(Item.last)
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test 'should show item as JSON' do
    get item_url(@item), as: :json
    assert_response :success

    json_actual = JSON.parse(response.body)
    json_expected = JSON.parse(
      ApplicationController.render(
        template: 'items/show',
        formats: :json,
        assigns: { :item => @item }
      )
    )

    json_expected.each do |k, v_expected|
      v_actual = json_actual[k]
      assert_equal(v_expected, v_actual)
    end
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { name: @item.name } }
    assert_redirected_to item_url(@item)
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end

    assert_redirected_to items_url
  end
end
