import { useState } from "react"
import { authService } from "../service/authService";
import toast from "react-hot-toast";
export const useAuth =()=>{
  const [loading, setLoading] = useState(false);
  const loginWithGoogle = async() =>{
    try{
      setLoading(true);
      const res = await authService.loginWithGoogle();
      console.log("Google login success:", res);
      toast.success("Đăng nhập Facebook thành công!");
    }
    catch(err){
      toast.error("Đăng nhập Google thất bại")
      console.log("Google login success:", err);
    } finally {
      setLoading(false);
    }
  }
  const loginWithFacebook = async() =>{
    try{
      setLoading(true);
      const res = await authService.loginWithGoogle();
      toast.success("Đăng nhập Facebook thành công!");
    }
    catch(err){
      toast.error("Đăng nhập Google thất bại!")
    } finally {
      setLoading(false);
    }
  }
   return {
    loginWithGoogle,
    loginWithFacebook,
    loading,
  };
}