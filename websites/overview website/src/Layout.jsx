import React from 'react';
import Navigation from '@/components/landing/Navigation';
import { useLocation } from 'react-router-dom';

export default function Layout({ children, currentPageName }) {
  return (
    <div className="min-h-screen bg-[#0a0f1a]">
      {children}
    </div>
  );
}