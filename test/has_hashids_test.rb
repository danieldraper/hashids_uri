require "test_helper"

class HashidsUriTest < Minitest::Test
  def setup
    @user = User.create
  end

  def test_to_param_does_not_equal_id
    refute_equal @user.id, @user.to_param
  end

  def test_to_param_is_hash
    hash_id = Hashids.new('', 6).encode(@user.id)

    assert_equal @user.to_param, hash_id
  end

  def test_can_change_salt
    salt = '423acc67d66d3ea3c31b'
    @user.class_eval { has_hashids_uri salt: salt }
    assert_equal @user.salt, salt
  end

  def test_can_change_min_length
    min_length = 24
    @user.class_eval { has_hashids_uri min_length: 24 }
    assert_equal @user.min_length, min_length
  end
end
