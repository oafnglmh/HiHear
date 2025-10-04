import React from "react";
import Splash from "../components/Splash";
import { usePageTransition } from "../hooks/usePageTransition";

const PageWrapper: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { isTransitioning } = usePageTransition(600);

  return (
    <>
      <Splash isVisible={isTransitioning} />
      <div
        className={`${
          isTransitioning ? "opacity-0" : "opacity-100"
        } transition-opacity duration-700`}
      >
        {children}
      </div>
    </>
  );
};

export default PageWrapper;
