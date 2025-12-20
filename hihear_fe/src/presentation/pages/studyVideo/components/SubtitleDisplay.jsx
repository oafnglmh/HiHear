import React from 'react';

export const SubtitleDisplay = ({ subtitleVi, subtitleOther }) => {
  return (
    <>
      <div className="bg-gradient-to-br from-gray-900 to-gray-800 p-6 min-h-[120px] flex items-center justify-center">
        {subtitleVi || subtitleOther ? (
          <div className="w-full max-w-4xl space-y-3">
            {subtitleVi && (
              <div className="text-center animate-slideIn">
                <p
                  className="text-white text-xl font-bold leading-relaxed px-4"
                  style={{
                    textShadow:
                      '0 2px 8px rgba(0,0,0,0.5), 0 0 20px rgba(16,185,129,0.3)',
                  }}
                >
                  {subtitleVi}
                </p>
              </div>
            )}

            {subtitleOther && (
              <div
                className="text-center animate-slideIn"
                style={{ animationDelay: '0.1s' }}
              >
                <div className="inline-block">
                  <p
                    className="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 via-teal-400 to-emerald-400 text-lg font-semibold leading-relaxed px-4"
                    style={{
                      textShadow: '0 2px 8px rgba(0,0,0,0.5)',
                      WebkitTextStroke: '0.5px rgba(16,185,129,0.2)',
                    }}
                  >
                    {subtitleOther}
                  </p>
                  <div className="h-0.5 bg-gradient-to-r from-transparent via-emerald-400 to-transparent mt-2"></div>
                </div>
              </div>
            )}
          </div>
        ) : (
          <p className="text-gray-500 text-sm">
            Phụ đề sẽ hiển thị tại đây...
          </p>
        )}
      </div>

      <style>{`
        @keyframes slideIn {
          from {
            opacity: 0;
            transform: translateY(10px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }
        
        .animate-slideIn {
          animation: slideIn 0.4s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }
      `}</style>
    </>
  );
};