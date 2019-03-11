import { combineReducers } from 'redux';
import AccountReducer from './AccountReducer';
import FeedReducer from './FeedReducer';
import PeopleReducer from './PeopleReducer';

export default combineReducers({
    user: AccountReducer,
    feed: FeedReducer,
    people: PeopleReducer
});