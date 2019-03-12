import { combineReducers } from 'redux';
import AccountReducer from './AccountReducer';
import FeedReducer from './FeedReducer';
import PeopleReducer from './PeopleReducer';
import JobReducer from './JobReducer';

export default combineReducers({
    user: AccountReducer,
    feed: FeedReducer,
    people: PeopleReducer
    job: JobReducer
});