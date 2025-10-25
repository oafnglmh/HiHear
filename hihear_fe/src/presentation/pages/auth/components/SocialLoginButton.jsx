import React from "react";

const SocialLoginButton = ({ type, onClick, label, loading }) => {
  const icons = {
    google: "https://cdn-icons-png.flaticon.com/512/281/281764.png",
    facebook: "https://cdn-icons-png.flaticon.com/512/733/733547.png",
  };

  return (
    <button
      className={`social-btn ${type}`}
      onClick={onClick}
      disabled={loading}
    >
      <img src={icons[type]} alt={`${type} icon`} />
      <span>{loading ? "Đang đăng nhập..." : label}</span>
    </button>
  );
};

export default SocialLoginButton;
