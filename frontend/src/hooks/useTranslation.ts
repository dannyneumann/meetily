import { useConfig } from '@/contexts/ConfigContext';
import en from '../translations/en.json';
import de from '../translations/de.json';

type TranslationKeys = typeof en;

export function useTranslation() {
  const { uiLanguage } = useConfig();
  
  const translations: Record<string, TranslationKeys> = {
    en,
    de
  };

  const t = (path: string) => {
    const keys = path.split('.');
    let current: any = translations[uiLanguage] || translations['en'];

    for (const key of keys) {
      if (current[key] === undefined) {
        // Fallback to English if key not found in selected language
        let fallback: any = translations['en'];
        for (const fallbackKey of keys) {
          if (fallback[fallbackKey] === undefined) return path;
          fallback = fallback[fallbackKey];
        }
        return fallback;
      }
      current = current[key];
    }

    return current;
  };

  return { t, uiLanguage };
}
