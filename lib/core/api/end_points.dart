class EndPoints {
  static const String baseUrl = 'https://';

// End Points

//********************************* USER FLOW **********************************//

// AUTH


//GET
  static const quranAudioEndpoint = 'api.dev-winner.com/api/quran';



  static const getHadeeth = 'https://hadeethenc.com/api/v1/';
  static const getHadeethCategories = 'categories/list/?language=ar';
  static const getHadeethDetails =
      'hadeethenc.com/api/v1/hadeeths/list/?language=ar&per_page=20';
  static const getHadeethInfo =
      'hadeethenc.com/api/v1/hadeeths/one/?language=ar';

  static const getQuran = 'api.alquran.cloud/v1/surah';

  static getSurah(String surahId) =>
      'api.alquran.cloud/v1/surah/$surahId/ar.alafasy';

  static getAudio(String surahId) =>
      'api.quran.com/api/v4/chapter_recitations/7/$surahId';

  static getAudios(String reciterId) =>
      'api.quran.com/api/v4/chapter_recitations/$reciterId?language=ar';

  static getJuz(String juzId) =>
      'api.alquran.cloud/v1/juz/$juzId/quran-uthmani';
  static const getRecitations =
      'api.quran.com/api/v4/resources/recitations?language=ar';

//POST


//DElETE

//PATCH

}
