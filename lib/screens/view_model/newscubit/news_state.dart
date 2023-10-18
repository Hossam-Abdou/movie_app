abstract class NewsState
{

}
class NewsInitState extends NewsState{}

class NewsLoadingState extends NewsState{}
class NewsSuccessState extends NewsState{}
class NewsErrorState extends NewsState{}

class LanguageChange extends NewsState{}