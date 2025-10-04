import { useEffect, useState } from "react";
import { useLocation } from "react-router-dom";

export function usePageTransition(duration = 1000) {
  const [isTransitioning, setIsTransitioning] = useState(true);
  const location = useLocation();

  useEffect(() => {
    setIsTransitioning(true);
    const timer = setTimeout(() => setIsTransitioning(false), duration);
    return () => clearTimeout(timer);
  }, [location, duration]);

  return { isTransitioning };
}
