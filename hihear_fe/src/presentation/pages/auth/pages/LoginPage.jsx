import React, { useEffect } from "react";
import "../auth.css";
import { BookOpen, Mic, Target } from "lucide-react";
import SocialLoginButton from "../components/SocialLoginButton";
import { useAuth } from "../hooks/useAuth";

const clientId =
  "300784897831-d4r7eiaeo9ffj6v7o36f0ruvj8s0vdid.apps.googleusercontent.com";

const LoginPage = () => {
  const { loginWithGoogle, loginWithFacebook, loading } = useAuth();

  useEffect(() => {
    const script = document.createElement("script");
    script.src = "https://accounts.google.com/gsi/client";
    script.async = true;
    script.defer = true;

    script.onload = () => {

      const handleCredentialResponse = (res) => {
        const idToken = res.credential;
        loginWithGoogle(idToken);
      };

      if (window.google) {
        window.google.accounts.id.initialize({
          client_id: clientId,
          callback: handleCredentialResponse,
          ux_mode: "popup",
          auto_select: false,
        });

        window.google.accounts.id.renderButton(
          document.getElementById("g_id_signin"),
          { theme: "outline", size: "large" }
        );
      }
    };

    document.body.appendChild(script);

    return () => {
      document.body.removeChild(script);
    };
  }, []);

  return (
    <div className="login-wrapper">
      <div className="login-left">
        <h1>
          Chào mừng đến với <span>HiHear</span>
        </h1>
        <p>
          Ứng dụng học tiếng Việt thông minh cho mọi lứa tuổi. Luyện nghe, nói và
          phát âm cùng AI để tự tin giao tiếp mỗi ngày.
        </p>

        <div className="feature-list">
          <div className="feature-item">
            <BookOpen size={26} />
            <span>Học qua tình huống thực tế</span>
          </div>
          <div className="feature-item">
            <Mic size={26} />
            <span>Luyện phát âm cùng AI</span>
          </div>
          <div className="feature-item">
            <Target size={26} />
            <span>Theo dõi tiến độ và mục tiêu</span>
          </div>
        </div>
      </div>

      <div className="login-right">
        <div className="login-card">
          <h2>Đăng nhập để tiếp tục</h2>
          <p>Chọn phương thức đăng nhập của bạn</p>

          <div className="social-buttons">
            <div id="g_id_signin"></div>

            <SocialLoginButton
              type="facebook"
              onClick={loginWithFacebook}
              label="Đăng nhập với Facebook"
              loading={loading}
            />
          </div>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
